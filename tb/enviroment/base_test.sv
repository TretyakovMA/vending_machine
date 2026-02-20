`ifndef BASE_TEST
`define BASE_TEST

virtual class base_test extends uvm_test;
	`uvm_component_utils(base_test);
	
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new
	
	env               env_h;
	env_config        env_config_h;
	
`ifdef USE_CUSTOM_REPORT_SERVER
	my_report_server  my_server; 
`endif

	initiator         initiator_h;



	// Функция для настройки конфигураций агентов
	virtual function void adjust_agent_configs();
		env_config_h.reset_agent_config_h.has_monitor     = 1;
		env_config_h.user_agent_config_h.has_monitor      = 1;
		env_config_h.admin_agent_config_h.has_monitor     = 0;
		env_config_h.register_agent_config_h.has_monitor  = 1;
		env_config_h.emergency_agent_config_h.has_monitor = 1;

		env_config_h.reset_agent_config_h.termination_after_reset     = 0;
		env_config_h.user_agent_config_h.termination_after_reset      = 1;
		env_config_h.admin_agent_config_h.termination_after_reset     = 1;
		env_config_h.register_agent_config_h.termination_after_reset  = 1;
		env_config_h.emergency_agent_config_h.termination_after_reset = 1;
	endfunction: adjust_agent_configs

	// Функция для выбора конфигурации env (выбор необходимых агентов)
	virtual function void adjust_env_config;
		return; //По умолчанию все включено
	endfunction: adjust_env_config
	


	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		// Создание конфигурации среды, с ней создаются все agent_config
		env_config_h = env_config::type_id::create("env_config_h", this);
		
		// Получение интерфейсов от top
		if(!uvm_config_db #(virtual interface reset_interface)::get(
			this, "", "reset_vif", env_config_h.reset_agent_config_h.vif
		)) `uvm_fatal(get_type_name(), "Faild to get reset interface")

		if(!uvm_config_db #(virtual interface user_interface)::get(
			this, "", "user_vif", env_config_h.user_agent_config_h.vif
		)) `uvm_fatal(get_type_name(), "Faild to get user interface")
			
		if(!uvm_config_db #(virtual interface admin_interface)::get(
			this, "", "admin_vif", env_config_h.admin_agent_config_h.vif
		)) `uvm_fatal(get_type_name(), "Faild to get admin interface")
			
		if(!uvm_config_db #(virtual interface register_interface)::get(
			this, "", "register_vif", env_config_h.register_agent_config_h.vif
		)) `uvm_fatal(get_type_name(), "Faild to get register interface")
			
		if(!uvm_config_db #(virtual interface emergency_interface)::get(
			this, "", "emergency_vif", env_config_h.emergency_agent_config_h.vif
		)) `uvm_fatal(get_type_name(), "Faild to get emergency interface")
			
		// Настройка agent_config
		adjust_agent_configs();

		// Настройка env_config
		adjust_env_config();
		
		// Готовый env_config отправляется к env
		uvm_config_db #(env_config)::set(
			this, "env_h", "env_config", env_config_h
		);
		env_h     = env::type_id::create("env_h", this);

		// Мой report_server создается только если симуляция запустилась с флагом
`ifdef USE_CUSTOM_REPORT_SERVER
		my_server = new();
`endif

		// СОздается компонент для запуска последовательности инициализации устройства
		initiator_h = initiator::type_id::create("initiator_h", this);

	endfunction: build_phase
	
	
	
	function void start_of_simulation_phase(uvm_phase phase);
		super.start_of_simulation_phase(phase);

		// Установка report_server
`ifdef USE_CUSTOM_REPORT_SERVER
		uvm_report_server::set_server(my_server);
`endif

		// Установка максимального времени симуляции
		// (если симуляция дойдет до 1 миллисекунды, то она завершится)
		uvm_top.set_timeout(10**9);

		// На всякий случай выводится топология проекта
		uvm_top.print_topology();
	endfunction: start_of_simulation_phase

endclass
`endif