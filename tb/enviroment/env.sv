`ifndef ENV
`define ENV
class env extends uvm_env;
	`uvm_component_utils(env);
	
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction
	
	user_agent             user_agent_h;
	admin_agent            admin_agent_h;
	register_agent         register_agent_h;
	errors_agent           errors_agent_h;
	
	user_coverage          user_coverage_h;
	user_scoreboard        user_scoreboard_h;
	
	
	register_env           register_env_h;
	
	env_config             env_config_h;
	
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		if(!uvm_config_db #(env_config)::get(this, "", "env_config", env_config_h))
			`uvm_fatal("ENV", "Faild to get config")
	
		uvm_config_db #(user_agent_config)::set(this, "user_agent_h*", "agent_config", env_config_h.user_agent_config_h);
		uvm_config_db #(admin_agent_config)::set(this, "admin_agent_h*", "agent_config", env_config_h.admin_agent_config_h);
		uvm_config_db #(register_agent_config)::set(this, "register_agent_h*", "agent_config", env_config_h.register_agent_config_h);
		uvm_config_db #(errors_agent_config)::set(this, "errors_agent_h*", "agent_config", env_config_h.errors_agent_config_h);

		user_agent_h      = user_agent::type_id::create("user_agent_h", this);
		admin_agent_h     = admin_agent::type_id::create("admin_agent_h", this);
		errors_agent_h    = errors_agent::type_id::create("errors_agent_h", this);
		
		
		register_agent_h  = register_agent::type_id::create("register_agent_h", this);
		register_env_h    = register_env::type_id::create("register_env_h", this);
		
		
		user_coverage_h   = user_coverage::type_id::create("coverage_h", this);
		user_scoreboard_h = user_scoreboard::type_id::create("user_scoreboard_h", this);

		end_work_dut      = new();
	endfunction
	
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		
		user_agent_h.ap.connect(user_scoreboard_h.a_imp);
		user_agent_h.ap.connect(user_coverage_h.analysis_export);
		
		
		register_agent_h.ap.connect(register_env_h.predictor_h.bus_in);
		register_env_h.reg_block_h.reg_map.set_sequencer(
			.sequencer(register_agent_h.sequencer_h),
			.adapter(register_env_h.adapter_h)
		);
	endfunction 
endclass
`endif