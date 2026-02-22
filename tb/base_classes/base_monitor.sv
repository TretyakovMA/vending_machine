`ifndef BASE_MONITOR
`define BASE_MONITOR
//==============================================================================
// base_monitor — параметризованный базовый класс монитора UVM
//
// Назначение:
//   • Предоставить единую инфраструктуру мониторинга транзакций и
//     реагирования на сигналы сброса для различных мониторов в тестбенче.
//   • Поддерживать два режима работы через флаг reset_sensitive:
//       1. reset_sensitive == 1 (по умолчанию):
//          монитор автоматически замораживается при сбросе и перезапускается
//          после его снятия. Используется для большинства функциональных тестов.
//       2. reset_sensitive == 0:
//          монитор продолжает мониторить даже во время сброса.
//          Используется для монитора, отслеживающего сигналы сброса.
//
// Архитектура (ключевые решения):
//   • Два независимых параллельных процесса в main_phase (при reset_sensitive=1):
//       _monitor_loop_()   — ожидает события сэмплинга, проверяет условие старта,
//                          собирает данные транзакции и отправляет в анализ-порт.
//       _handle_reset_() — постоянно следит за rst_n и управляет жизненным
//                          циклом _monitor_loop_.
//   • Используется классический «disable/fork-join_none» паттерн — 
//     способ «мягкого» перезапуска потока в UVM.
//   • При обнаружении сброса текущий процесс мониторинга принудительно останавливается,
//     чтобы избежать сбора некорректных данных во время сброса.
//
// Наследование (рекомендуемый порядок):
//   1. Производный базовый монитор (с реализацией ожиданий сигналов).
//   2. Конкретные мониторы <- наследуются от базового и реализуют только 
//      методы обработки интерфейса:
//          pure virtual task _wait_for_sampling_event_(); 
//          pure virtual task _collect_transaction_data_(TRANSACTION_TYPE tr);
//==============================================================================
virtual class base_monitor #(
    type INTERFACE_TYPE,
	type TRANSACTION_TYPE
) extends uvm_monitor;

	`uvm_component_param_utils(base_monitor #(INTERFACE_TYPE, TRANSACTION_TYPE))

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new


	// Интерфейс, через который монитор получает сигналы от DUT.
    // Устанавливается агентом в connect_phase.
	INTERFACE_TYPE   vif;

	// Текущая обрабатываемая транзакция.
    TRANSACTION_TYPE transaction;

	// Флаг, определяющий, нужно ли монитору реагировать на сброс.
	// Устанавливается агентом из конфигурации.
	bit reset_sensitive = 1;

    uvm_analysis_port #(TRANSACTION_TYPE) ap;
	
	

	//======================== Методы обработки интерфейса ======================

	// Задача для ожидания события начала мониторинга.
	pure virtual task _wait_for_sampling_event_(); 

	// Задача для записи информации из интерфейса в транзакцию
    pure virtual task _collect_transaction_data_ (TRANSACTION_TYPE tr); 

	

	//========================== Вспомогательные методы =========================

	// Задача для ожидания, пока не опустится сигнал сброса
	pure virtual task _wait_for_reset_deassert_(); 
	
	// Задача для ожидания сигнала сброса
	pure virtual task _wait_for_reset_assert_();
	


	//=========================== Основная логика ===============================

	// Бесконечный поиск сигнала сброса
	// При каждом assert rst_n:
    //   1. Убивает текущий _monitor_loop_.
    //   2. Запускает новый экземпляр _monitor_loop_ в отдельном процессе.
	extern local task _handle_reset_();

	// Основной рабочий цикл драйвера.
	//   • Ждёт снятия сброса (инициализация DUT или перезапуск после сброса).
    //   • В бесконечном цикле: ждет событие начала мониторинга  
	//     -> вызывает _collect_transaction_data_
    //     -> отправляет транзакцию с помошью write.
    //   Этот процесс может быть убит и перезапущен задачей _handle_reset_.
	extern local task _monitor_loop_(); 

	


	//=========================== Фазы UVM ================================
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		ap = new("ap", this);
	endfunction: build_phase    

	// Здесь начинается вся основная работа драйвера.
	virtual task main_phase(uvm_phase phase);
		super.main_phase(phase);

		// Если установлен reset_sensitive, то монитор реагирует на сброс
		// Два независимых процесса:
        	// 1. _monitor_loop_ — основная работа
        	// 2. _handle_reset_ — мониторинг сброса
        	// join_any нужен, чтобы main_phase не блокировался навсегда
		if(reset_sensitive) fork
			_handle_reset_();
			_monitor_loop_();
		join
		

		// Если reset_sensitive = 0, то монитор игнорирует сброс
		else begin
			_monitor_loop_();
		end
	endtask: main_phase
	
endclass: base_monitor



//=========================== Реализация задач ===========================
task base_monitor::_handle_reset_(); 
	forever begin
		// Ждём, пока сигнал сброса станет активным
		_wait_for_reset_assert_();
		`uvm_info(get_type_name(), "Reset detected", UVM_FULL)

		// Убиваем текущий рабочий процесс
		disable _monitor_loop_; 
			
		// Запускаем новый экземпляр _monitor_loop_ в отдельном процессе
        // (join_none, чтобы _handle_reset_ продолжал жить)
		fork
            _monitor_loop_(); 
		join_none
	end
endtask: _handle_reset_



task base_monitor::_monitor_loop_(); 

	// Ждём снятия сигнала сброса
	_wait_for_reset_deassert_(); 

	// Начинаем обычную работу монитора
	forever begin
		// Ждем момента, когда нужно начинать мониторинг
		_wait_for_sampling_event_();

		// Создаем новую транзакцию
		transaction = TRANSACTION_TYPE::type_id::create("tr");
		`uvm_info(get_type_name(), "Start work", UVM_FULL)

		// Собираем данные транзакции
		_collect_transaction_data_(transaction); 

		`uvm_info(get_type_name(), `GET_TR_STR(transaction), UVM_LOW)
		// Отправляем транзакцию на анализ
		ap.write(transaction); 
		`uvm_info(get_type_name(), "End work", UVM_FULL)
			
	end
endtask: _monitor_loop_

`endif