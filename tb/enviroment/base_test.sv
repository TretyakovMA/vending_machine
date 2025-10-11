`ifndef BASE_TEST
`define BASE_TEST

virtual class base_test extends uvm_test;
	`uvm_component_utils(base_test);
	
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new
	
	env                    env_h;
	env_config             env_config_h;
	
	user_agent_config      user_agent_config_h;
	admin_agent_config     admin_agent_config_h;
	register_agent_config  register_agent_config_h;
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env_config_h = env_config::type_id::create("env_config_h", this);

		user_agent_config_h     = user_agent_config::type_id::create("user_agent_config_h", this);
		admin_agent_config_h    = admin_agent_config::type_id::create("admin_agent_config_h", this);
		register_agent_config_h = register_agent_config::type_id::create("register_agent_config_h", this);

		
		
		if(!uvm_config_db #(virtual interface user_interface)::get(this, "", "user_vif", user_agent_config_h.vif))
			`uvm_fatal("BASE_TEST", "Faild to get user interface")
		if(!uvm_config_db #(virtual interface admin_interface)::get(this, "", "admin_vif", admin_agent_config_h.vif))
			`uvm_fatal("BASE_TEST", "Faild to get admin interface")
		if(!uvm_config_db #(virtual interface register_interface)::get(this, "", "register_vif", register_agent_config_h.vif))
			`uvm_fatal("BASE_TEST", "Faild to get register interface")
		

		user_agent_config_h.has_monitor      = 1;
		admin_agent_config_h.has_monitor     = 0;
		register_agent_config_h.has_monitor  = 1;
		
		env_config_h.user_agent_config_h     = user_agent_config_h;
		env_config_h.admin_agent_config_h    = admin_agent_config_h;
		env_config_h.register_agent_config_h = register_agent_config_h;

		
		uvm_config_db #(env_config)::set(this, "env_h*", "env_config", env_config_h);
		
		env_h = env::type_id::create("env_h", this);
		
	endfunction: build_phase
	
	
	
	function void start_of_simulation_phase(uvm_phase phase);
		super.start_of_simulation_phase(phase);
		
		uvm_top.set_timeout(5ms);
		
		uvm_top.print_topology();
	endfunction: start_of_simulation_phase

endclass
`endif