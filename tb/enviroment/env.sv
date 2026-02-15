`ifndef ENV
`define ENV
class env extends uvm_env;
	`uvm_component_utils(env);
	
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction
	
	env_config             env_config_h;

	user_agent             user_agent_h;
	admin_agent            admin_agent_h;
	register_agent         register_agent_h;
	error_agent            error_agent_h;
	
	user_checker		   user_checker_h;
	vm_coverage            coverage_h;
	vm_scoreboard          scoreboard_h;

	register_env           register_env_h;
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		//Получение env_config от текущего теста
		if(!uvm_config_db #(env_config)::get(this, "", "env_config", env_config_h))
			`uvm_fatal(get_type_name(), "Faild to get env_config")

		//Покрытие и scoreboard создается во всех тестах	
		user_checker_h	  = user_checker::type_id::create("user_checker_h", this);
		uvm_config_db #(user_checker)::set(this, "scoreboard_h", "user_checker", user_checker_h);
		coverage_h        = vm_coverage::type_id::create("coverage_h", this);
		scoreboard_h      = vm_scoreboard::type_id::create("scoreboard_h", this);

		//Создаются только те агенты, которые требуются тесту
		if(env_config_h.has_user_agent) begin
			uvm_config_db #(user_agent_config)::set(this, "user_agent_h", "agent_config", env_config_h.user_agent_config_h);
			user_agent_h      = user_agent::type_id::create("user_agent_h", this);
			uvm_config_db #(user_checker)::set(this, "user_agent_h.sequencer_h", "user_checker", user_checker_h);
		end
		if(env_config_h.has_admin_agent) begin
			uvm_config_db #(admin_agent_config)::set(this, "admin_agent_h", "agent_config", env_config_h.admin_agent_config_h);
			admin_agent_h     = admin_agent::type_id::create("admin_agent_h", this);
		end
		if(env_config_h.has_register_agent) begin
			uvm_config_db #(register_agent_config)::set(this, "register_agent_h", "agent_config", env_config_h.register_agent_config_h);
			register_agent_h  = register_agent::type_id::create("register_agent_h", this);
		end
		if(env_config_h.has_error_agent) begin
			uvm_config_db #(error_agent_config)::set(this, "error_agent_h", "agent_config", env_config_h.error_agent_config_h);
			error_agent_h     = error_agent::type_id::create("error_agent_h", this);
		end

		//Регистры и необходимые им компоненты создаются по флагу has_register_env
		if(env_config_h.has_register_env) begin
			register_env_h    = register_env::type_id::create("register_env_h", this);
			
			scoreboard_h.has_reg_model = 1; //Разрешаем доступ scoreboard к регистровой
		end
		
	endfunction: build_phase
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);

		//Созданные агенты подключаются к scoreboard_h и покрытию
		if(env_config_h.has_user_agent) begin
			user_agent_h.ap.connect(coverage_h.analysis_export);
			user_agent_h.ap.connect(scoreboard_h.user_imp);
		end

		if(env_config_h.has_error_agent)
			error_agent_h.ap.connect(scoreboard_h.error_imp);
		
		if(env_config_h.has_register_agent) begin
			register_agent_h.ap.connect(scoreboard_h.register_imp);
			register_agent_h.ap.connect(register_env_h.predictor_h.bus_in);
			register_env_h.reg_block_h.reg_map.set_sequencer(
				.sequencer(register_agent_h.sequencer_h),
				.adapter(register_env_h.adapter_h)
			);
		end
		
	endfunction: connect_phase
endclass
`endif