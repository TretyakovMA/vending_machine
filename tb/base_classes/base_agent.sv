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
//   • Все базовые классы (base_agent, base_driver, base_monitor, base_agent_config)
//     должны использоваться вместе для обеспечения согласованной работы с
//     обработкой сбросов и конфигурацией. Не рекомендуется смешивать с
//     несовместимыми реализациями.
//   • Для активных агентов (is_active == UVM_ACTIVE) обязательно переопределите
//     метод set_sequencer_name() в производном классе, чтобы задать уникальное
//     имя секвенсера. Это имя используется для установки секвенсера в
//     uvm_config_db, позволяя последовательностям легко обращаться к нему.
//   • Конфигурация агента (base_agent_config) должна быть создана и установлена
//     в env или вышестоящем компоненте через uvm_config_db в build_phase.
//   • Наследование: Конкретные агенты (например, user_agent) наследуются от
//     base_agent, указывая используемые типы интерфейса, транзакции, драйвера и монитора
//     в параметрах. Если какой-либо компонент (например монитор) не требуется
//     в агенте, то параметр можно не указывать (требуется согласование с agent_config).
//==============================================================================
virtual class base_agent #(
	type INTERFACE_TYPE,
	type TRANSACTION_TYPE,
	type DRIVER_TYPE    = void_driver   #(INTERFACE_TYPE, TRANSACTION_TYPE),
	type MONITOR_TYPE   = void_monitor  #(INTERFACE_TYPE, TRANSACTION_TYPE),
	type SEQUENCER_TYPE = uvm_sequencer #(TRANSACTION_TYPE)
) extends uvm_agent;

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

	// Функция для указания имения секвенсера 
    // он будет отправлен в config_db с данным ключем
    virtual function string set_sequencer_name();
        return "";  
    endfunction: set_sequencer_name

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		// Получение конфигурации от env
		if(!uvm_config_db #(base_agent_config #(INTERFACE_TYPE))::get(this, "", "agent_config", config_h))
			`uvm_fatal(get_type_name(), "Faild to get config")
	
		// Драйвер и секвенсер создаются, если агент настроен быть активным
		if (config_h.is_active == UVM_ACTIVE) begin
			driver_h       = DRIVER_TYPE::type_id::create("driver_h", this);
			sequencer_h    = SEQUENCER_TYPE::type_id::create("sequencer_h", this);

			// Агент задает имя секвенсера
			sequencer_name = set_sequencer_name();
			// Проверка, что имя секвенсера указано
			if (sequencer_name == "") 
                `uvm_warning(get_type_name(), "Sequencer name not provided via set_sequencer_name()");
			// Запись секвенсера в uvm_config_db
			uvm_config_db #(SEQUENCER_TYPE)::set(null, "*", sequencer_name, sequencer_h);

			// Запись драйвера в uvm_config_db
			uvm_config_db #(DRIVER_TYPE)::set(null, "*", driver_h.get_type_name(), driver_h);
		end 
		
		// Монитор создается, если так указано в конфигурации
		if (config_h.has_monitor == 1) begin
			monitor_h   = MONITOR_TYPE::type_id::create("monitor_h", this);
			ap          = new("ap", this);
		end
		
	endfunction
	
	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		// Созданные компоненты подключаются к необходимым портам и флагам
		if (config_h.is_active == UVM_ACTIVE) begin
			driver_h.seq_item_port.connect(sequencer_h.seq_item_export);
			driver_h.vif             = config_h.vif;
			driver_h.reset_sensitive = config_h.reset_sensitive;
		end
		if (config_h.has_monitor == 1) begin
			monitor_h.ap.connect(ap);
			monitor_h.vif             = config_h.vif;
			monitor_h.reset_sensitive = config_h.reset_sensitive;
		end
		
	endfunction 

endclass
`endif