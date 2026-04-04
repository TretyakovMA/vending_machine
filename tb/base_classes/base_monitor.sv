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
//==============================================================================
virtual class base_monitor #(
    type INTERFACE_TYPE,
	type TRANSACTION_TYPE
) extends uvm_monitor;

	`uvm_component_param_utils(base_monitor #(INTERFACE_TYPE, TRANSACTION_TYPE))

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new


`ifdef BASE_AGENT_CONFIG
	local base_agent_config #(INTERFACE_TYPE) config_h;
`endif

	// Интерфейс, через который монитор получает сигналы от DUT.
	protected INTERFACE_TYPE vif;

	// Текущая обрабатываемая транзакция.
    local TRANSACTION_TYPE   transaction;

	// Флаг, определяющий, нужно ли монитору реагировать на сброс.
	local bit                reset_sensitive;

    uvm_analysis_port #(TRANSACTION_TYPE) ap;
	
	

	//======================== Методы обработки интерфейса ======================

	// Задача для ожидания события начала мониторинга.
	pure virtual task _wait_for_sampling_event_(); 

	// Задача для записи информации из интерфейса в транзакцию
    pure virtual task _collect_transaction_data_ (TRANSACTION_TYPE tr); 

	

	//========================== Вспомогательные методы =========================
	// Эти методы должны быть переопределены, если reset_sensitive == 1.

	// Задача для ожидания, пока не опустится сигнал сброса
	extern virtual task _wait_for_reset_deassert_(); 
	
	// Задача для ожидания сигнала сброса
	extern virtual task _wait_for_reset_assert_();

	// Метод для установки конфигурации монитора, если не используется base_agent_config
	// Пример переопределения:
	//
	// virtual function void get_mon_cfg();
	//    if (!uvm_config_db #(virtual my_if)::get(this, "", "my_vif", vif))
	//        `uvm_fatal(get_type_name(), "Failed to get virtual interface from config_db")
	//	  reset_sensitive = 1;
	// endfunction: get_mon_cfg
	virtual function void get_mon_cfg();
		`uvm_fatal(get_type_name(), "get_mon_cfg() must be overridden if not using base_agent_config")
	endfunction: get_mon_cfg



	//=========================== Основная логика ===============================

	// Бесконечный поиск сигнала сброса
	// При каждом assert rst:
    //   1. Убивает текущий _monitor_loop_.
    //   2. Запускает новый экземпляр _monitor_loop_ в отдельном процессе.
	extern local task _handle_reset_(uvm_phase phase);

	// Основной рабочий цикл монитора.
	//   • Ждёт снятия сброса (инициализация DUT или перезапуск после сброса).
    //   • В бесконечном цикле: ждет событие начала мониторинга  
	//     -> вызывает _collect_transaction_data_
    //     -> отправляет транзакцию с помошью write.
    //   Этот процесс может быть убит и перезапущен задачей _handle_reset_.
	extern local task _monitor_loop_(uvm_phase phase); 

	


	//=========================== Фазы UVM ================================
	
	// Получение конфигурации из config_db, настройка интерфейса и анализ-порта.
	extern local function void build_phase(uvm_phase phase);

	// Проверка, что интерфейс установлен
	local task reset_phase(uvm_phase phase);
		super.reset_phase(phase);
		if(vif == null) `uvm_fatal(get_type_name(), "Virtual interface not set")
	endtask: reset_phase

	// Основная работа монитора.
	local task main_phase(uvm_phase phase);
		super.main_phase(phase);

		// Если установлен reset_sensitive, то монитор реагирует на сброс
		// Два независимых процесса:
        	// 1. _monitor_loop_ — основная работа
        	// 2. _handle_reset_ — мониторинг сброса
        	// join_any нужен, чтобы main_phase не блокировался навсегда
		if(reset_sensitive) fork
			_handle_reset_(phase);
			_monitor_loop_(phase);
		join_any
		

		// Если reset_sensitive = 0, то монитор игнорирует сброс
		else begin
			_monitor_loop_(phase);
		end
	endtask: main_phase
	
endclass: base_monitor



//=========================== Реализация задач ===========================
task base_monitor::_wait_for_reset_deassert_();
    if (!reset_sensitive) begin
        return;
    end

    // Если reset_sensitive == 1, а метод не переопределён — ошибка
    `uvm_fatal(get_type_name(),
        "_wait_for_reset_deassert_() must be overridden when reset_sensitive == 1")
endtask



task base_monitor::_wait_for_reset_assert_();
    // Этот метод вызывается только при reset_sensitive == 1
    `uvm_fatal(get_type_name(),
        "_wait_for_reset_assert_() must be overridden when reset_sensitive == 1")
endtask



function void base_monitor::build_phase(uvm_phase phase);
	super.build_phase(phase);
`ifdef BASE_AGENT_CONFIG
	if(uvm_config_db #(base_agent_config #(INTERFACE_TYPE))::get(
		this, "", "config", config_h
	)) begin
		vif             = config_h.vif;
		reset_sensitive = config_h.reset_sensitive;

		`uvm_info(get_type_name(), "Configuration taken from base_agent_config", UVM_FULL)
	end

	else begin
		`uvm_warning(get_type_name(), 
            "base_agent_config not found in config_db. Falling back to get_mon_cfg()")
		get_mon_cfg();
	end
`else
	`uvm_warning(get_type_name(), 
		"BASE_AGENT_CONFIG not defined. Using direct get_mon_cfg()")
	get_mon_cfg();
`endif
	ap = new("ap", this);
endfunction: build_phase



task base_monitor::_handle_reset_(uvm_phase phase); 
	forever begin
		// Ждём, пока сигнал сброса станет активным
		_wait_for_reset_assert_();
		`uvm_info(get_type_name(), "Reset detected", UVM_FULL)

		// Убиваем текущий рабочий процесс
		disable _monitor_loop_; 
			
		// Запускаем новый экземпляр _monitor_loop_ в отдельном процессе
        // (join_none, чтобы _handle_reset_ продолжал жить)
		fork
            _monitor_loop_(phase); 
		join_none
	end
endtask: _handle_reset_



task base_monitor::_monitor_loop_(uvm_phase phase); 

	// Ждём снятия сигнала сброса
	_wait_for_reset_deassert_(); 

	// Начинаем обычную работу монитора
	forever begin
		// Ждем момента, когда нужно начинать мониторинг
		_wait_for_sampling_event_();

		// Если прошло условие начала мониторинга, то поднимаем возражение
		// чтобы тест не завершился, пока DUT работает
		phase.raise_objection(this);

		// Создаем новую транзакцию
		transaction = TRANSACTION_TYPE::type_id::create("tr");
		`uvm_info(get_type_name(), "Start work", UVM_FULL)

		// Собираем данные транзакции
		_collect_transaction_data_(transaction); 

`ifdef CUSTOM_REPORT_MACROS
		`uvm_info(get_type_name(), `GET_TR_STR(transaction), UVM_LOW)
`endif
		// Отправляем транзакцию на анализ
		ap.write(transaction); 
		`uvm_info(get_type_name(), "End work", UVM_FULL)

		// Транзакция отправлена в scoreboard, можно снять возражение
		phase.drop_objection(this);
			
	end
endtask: _monitor_loop_

`endif