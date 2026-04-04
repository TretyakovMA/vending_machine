`ifndef BASE_AGENT
`define BASE_AGENT
//==============================================================================
// base_agent — параметризованный базовый класс агента UVM
//
// Назначение:
//   • Предоставить единую инфраструктуру для создания агентов, включая
//     драйвер, секвенсер и монитор, с учетом конфигурации (активный/пассивный,
//     наличие монитора, чувствительность к сбросу).
//   • Обеспечить единообразное подключение компонентов и настройку через
//     конфигурацию, получаемую из uvm_config_db.
//
// Использование (ключевые рекомендации):
//   • Все базовые классы (base_agent, base_driver, base_monitor)
//     рекомендуется использоваться вместе.
//   • При желании, можно использовать другие реализации драйвера и монитора.
//     Для корректного подключения монитора к анализ-порту агента
//     необходимо переопределить метод connect_monitor_to_analysis_port().
//   • Использование base_agent_config обязательно.
//   • По умолчанию все созданные компоненты отправляются в uvm_config_db 
//     с ключом - именем класса. Для запрета отправки необходимо переопределить методы
//     do_publish_driver(), do_publish_sequencer() и do_publish_monitor().
//   • Для активных агентов (is_active == UVM_ACTIVE) обязательно переопределите
//     метод set_sequencer_name() в производном классе, чтобы задать уникальное
//     имя секвенсера. Это имя используется для установки секвенсера в
//     uvm_config_db, позволяя последовательностям легко обращаться к нему.
//   • Конфигурация агента (base_agent_config) должна быть создана и установлена
//     в env или вышестоящем компоненте через uvm_config_db в build_phase.
//   • Наследование: Конкретные агенты (например, user_agent) наследуются от
//     base_agent, указывая используемые типы интерфейса, транзакции, драйвера и монитора
//     в параметрах. Если в проекте используются void_classes, то ненужные компоненты
//     (например монитор) можно не указывать в параметрах 
//     (требуется согласование с base_agent_config).
//==============================================================================

`ifdef VOID_CLASSES
virtual class base_agent #(
	type INTERFACE_TYPE,
	type TRANSACTION_TYPE,
	type DRIVER_TYPE    = void_driver   #(INTERFACE_TYPE, TRANSACTION_TYPE),
	type MONITOR_TYPE   = void_monitor  #(INTERFACE_TYPE, TRANSACTION_TYPE),
	type SEQUENCER_TYPE = uvm_sequencer #(TRANSACTION_TYPE)
) extends uvm_agent;

`else
virtual class base_agent #(
	type INTERFACE_TYPE,
	type TRANSACTION_TYPE,
	type DRIVER_TYPE,
	type MONITOR_TYPE,
	type SEQUENCER_TYPE = uvm_sequencer #(TRANSACTION_TYPE)
) extends uvm_agent;
`endif

    `uvm_component_param_utils (base_agent #(
		INTERFACE_TYPE, 
		TRANSACTION_TYPE, 
		DRIVER_TYPE, 
		MONITOR_TYPE, 
		SEQUENCER_TYPE
		)
	)

    function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new

	base_agent_config #(INTERFACE_TYPE) config_h;

	DRIVER_TYPE     driver_h;
	SEQUENCER_TYPE  sequencer_h;
	MONITOR_TYPE    monitor_h;

	string          sequencer_name;

	uvm_analysis_port #(TRANSACTION_TYPE) ap;



	// Функция для указания имения секвенсера, 
    // он будет отправлен в config_db с данным ключем
    virtual function string set_sequencer_name();
        return "";  
    endfunction: set_sequencer_name

	// Функции для контроля публикации драйвера, секвенсера и монитора в config_db
	virtual function bit do_publish_driver();
    	return 1;
	endfunction

	virtual function bit do_publish_sequencer();
    	return 1;
	endfunction

	virtual function bit do_publish_monitor();
		return 1;
	endfunction



	local function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		// Получение конфигурации от env
		if(!uvm_config_db #(base_agent_config #(INTERFACE_TYPE))::get(this, "", "agent_config", config_h))
			`uvm_fatal(get_type_name(), "Faild to get config")
	
		// Драйвер и секвенсер создаются, если агент настроен быть активным
		if (config_h.is_active == UVM_ACTIVE) begin
			driver_h       = DRIVER_TYPE::type_id::create("driver_h", this);
			sequencer_h    = SEQUENCER_TYPE::type_id::create("sequencer_h", this);

			// Передача конфигурации драйверу через uvm_config_db
			uvm_config_db #(base_agent_config #(INTERFACE_TYPE))::set(this, driver_h.get_name(), "config", config_h);

			// Агент задает имя секвенсера
			sequencer_name = set_sequencer_name();
			
			// Запись секвенсера в uvm_config_db
    		if (do_publish_sequencer() && sequencer_h != null && sequencer_name != "") begin
        		uvm_config_db #(SEQUENCER_TYPE)::set(null, "*", sequencer_name, sequencer_h);
    		end

			// Запись драйвера в uvm_config_db
			if (do_publish_driver() && driver_h != null) begin
        		uvm_config_db #(DRIVER_TYPE)::set(null, "*", driver_h.get_type_name(), driver_h);
    		end
			
		end 
		
		// Монитор создается, если так указано в конфигурации
		if (config_h.has_monitor == 1) begin
			monitor_h   = MONITOR_TYPE::type_id::create("monitor_h", this);
			
			// Передача конфигурации монитору через uvm_config_db
			uvm_config_db #(base_agent_config #(INTERFACE_TYPE))::set(this, monitor_h.get_name(), "config", config_h);

			// Запись монитора в uvm_config_db
			if(do_publish_monitor() && monitor_h != null) begin
				uvm_config_db #(MONITOR_TYPE)::set(null, "*", monitor_h.get_type_name(), monitor_h);
			end
			
			ap          = new("ap", this);
		end

	endfunction
	
	local function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);

		// Созданные компоненты подключаются к необходимым портам и флагам
		if (config_h.is_active == UVM_ACTIVE) begin
			driver_h.seq_item_port.connect(sequencer_h.seq_item_export);
		end
		if (config_h.has_monitor == 1) begin
			connect_monitor_to_analysis_port();
		end
		
	endfunction 

	virtual function void connect_monitor_to_analysis_port();
		// Если в проекте есть базовый монитор, то пытаемся подключится 
		// к производному монитору
`ifdef BASE_MONITOR
		// Пытаемся привести монитор к нашему базовому типу, где точно есть 'ap'
		base_monitor #(INTERFACE_TYPE, TRANSACTION_TYPE) b_mon;

		if ($cast(b_mon, monitor_h)) begin
			// Если это наш монитор — подключаем
			b_mon.ap.connect(this.ap);
		end 
		else begin
			// Если монитор сторонний, то пользователь должен подключить его вручную в наследнике агента.
			`uvm_warning(get_type_name(), "The monitor's analysis port is not connected to the agent's analysis port")
		end
`else
		// Если нет базового монитора, то все подключение в руках пользователя
		`uvm_warning(get_type_name(), "The monitor's analysis port is not connected to the agent's analysis port")
`endif
	endfunction

endclass
`endif