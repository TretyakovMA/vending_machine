`ifndef BASE_DRIVER
`define BASE_DRIVER
//==============================================================================
// base_driver — параметризованный базовый класс драйвера UVM
//
// Назначение:
//   • Предоставить единую инфраструктуру обработки транзакций и
//     реагирования на сигналы сброса для различных драйверов в тестбенче.
//   • Поддерживать два режима работы через флаг reset_sensitive:
//       1. reset_sensitive == 1 (по умолчанию):
//          драйвер автоматически замораживается при сбросе и перезапускается
//          после его снятия. Используется для большинства функциональных тестов.
//       2. reset_sensitive == 0:
//          драйвер продолжает подавать сигналы даже во время сброса.
//          Используется для драйвера, подающего сигналы сброса.
//
// Архитектура (ключевые решения):
//   • Два независимых параллельных процесса в main_phase (при reset_sensitive=1):
//       _drive_loop_()   — получает транзакции от секвенсера и вызывает
//                          пользовательский _drive_transaction_().
//       _handle_reset_() — постоянно следит за rst_n и управляет жизненным
//                          циклом _drive_loop_.
//   • Используется классический «disable/fork-join_none» паттерн — 
//     способ «мягкого» перезапуска потока в UVM.
//   • При обнаружении сброса текущая транзакция принудительно завершается
//     через item_done(), чтобы секвенсер не завис навсегда.
//
// Наследование (рекомендуемый порядок):
//   1. Производный базовый драйвер (с реализацией ожиданий сигналов).
//   2. Конкретные драйверы <- наследуются от базового и реализуют только 
//      методы обработки интерфейса:
//          pure virtual task _reset_();
//          pure virtual task _drive_transaction_(TRANSACTION_TYPE tr);
//==============================================================================

virtual class base_driver #(
	type INTERFACE_TYPE,
	type TRANSACTION_TYPE
) extends uvm_driver #(TRANSACTION_TYPE);

	`uvm_component_param_utils(base_driver #(INTERFACE_TYPE, TRANSACTION_TYPE))
	
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new



	// Интерфейс, через который драйвер общается с DUT.
    // Устанавливается агентом в connect_phase.
	INTERFACE_TYPE   vif; 

	// Текущая обрабатываемая транзакция
	TRANSACTION_TYPE transaction;

	// Флаг, определяющий поведение драйвера при сбросе.
    // Устанавливается агентом из конфигурации.
	bit reset_sensitive = 1;



	//======================== Методы обработки интерфейса ======================

	// Вызывается при каждом активном сбросе (и в reset_phase).
	pure virtual task _reset_();

	// Вызывается для каждой полученной от секвенсера транзакции.
	pure virtual task _drive_transaction_ (TRANSACTION_TYPE tr);



	//========================== Вспомогательные методы =========================

	// Задача для ожидания, пока не опустится сигнал сброса
	pure virtual task _wait_for_reset_deassert_();

	// Задача для ожидания сигнала сброса
	pure virtual task _wait_for_reset_assert_();



	//=========================== Основная логика ===============================

	// Бесконечный поиск сигнала сброса
	// При каждом assert rst_n:
    //   1. Убивает текущий _drive_loop_ (чтобы ничего не подавалось на DUT).
    //   2. Вызывает _reset_() -> все сигналы интерфейса в начальное состояние.
    //   3. Завершает текущую транзакцию (item_done), чтобы секвенсер не завис.
    //   4. Запускает новый экземпляр _drive_loop_ в отдельном процессе.
	extern local task _handle_reset_(); 

	// Основной рабочий цикл драйвера.
	//   • Ждёт снятия сброса (инициализация DUT или перезапуск после сброса).
    //   • В бесконечном цикле получает транзакцию -> вызывает _drive_transaction_
    //     -> вызывает item_done.
    //   Этот процесс может быть убит и перезапущен задачей _handle_reset_.
	extern local task _drive_loop_();
	


	//============================== Фазы UVM ====================================
	
	// Сбрасываем интерфейс в начале тестирования.
	virtual task reset_phase(uvm_phase phase);
		super.reset_phase(phase);
		_reset_();
	endtask: reset_phase
	
	// Здесь начинается вся основная работа драйвера.
	virtual task main_phase(uvm_phase phase);
		super.main_phase(phase);

		// Если установлен reset_sensitive, то драйвер реагирует на сброс
		// Два независимых процесса:
        	// 1. _drive_loop_   — основная работа
        	// 2. _handle_reset_ — мониторинг сброса
        	// join_any нужен, чтобы main_phase не блокировался навсегда
		if (reset_sensitive) fork
			_drive_loop_();   
			_handle_reset_(); 
		join_any



		// Если reset_sensitive = 0, то драйвер игнорирует сброс
		// Используется для драйвера, подающего сигналы сброса
		else begin
			_drive_loop_(); 
		end
	endtask: main_phase

endclass: base_driver



//=========================== Реализация задач ===========================
task base_driver::_handle_reset_();
	forever begin
		// 1. Ждём, пока сигнал сброса станет активным
		_wait_for_reset_assert_();       
		`uvm_info(get_type_name(), "Reset detected", UVM_FULL)

		// 2. Критично: убиваем текущий рабочий процесс, чтобы мгновенно
        //    прекратить подачу любых сигналов на DUT.
		disable _drive_loop_;

		// 3. Сбрасываем текущие сигналы         
		_reset_();

		// 4. Если в момент сброса драйвер обрабатывал транзакцию — 
        //    корректно завершаем её
		if(transaction != null) begin
			seq_item_port.item_done();  
			transaction = null; 
		end

		// 5. Запускаем новый экземпляр _drive_loop_ в отдельном процессе
        // (join_none, чтобы _handle_reset_ продолжал жить)
		fork
            _drive_loop_(); 
		join_none
	end
endtask: _handle_reset_



task base_driver::_drive_loop_();

	// Ждём снятия сигнала сброса
	_wait_for_reset_deassert_();

	// Начинаем обычную работу драйвера
	forever begin
		// Получаем очередную транзакцию от секвенсера
		seq_item_port.get_next_item(transaction);
		`uvm_info(get_type_name(), "Start work", UVM_HIGH)

		// Записываем транзакцию в интерфейс
        _drive_transaction_(transaction);

		// Сообщаем секвенсеру, что транзакция отработана
		`uvm_info(get_type_name(), "End work", UVM_HIGH)
        seq_item_port.item_done();
	end
endtask: _drive_loop_

`endif