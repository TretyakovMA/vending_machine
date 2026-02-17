`ifndef ENV_CONFIG
`define ENV_CONFIG
class env_config extends uvm_object;
	`uvm_object_utils(env_config)

	user_agent_config      user_agent_config_h;
	admin_agent_config     admin_agent_config_h;
	register_agent_config  register_agent_config_h;
	emergency_agent_config emergency_agent_config_h;

	bit has_user_agent      = 1;
    bit has_admin_agent     = 1;
    bit has_register_agent  = 1;
    bit has_emergency_agent = 1;
	
	bit has_register_env    = 1;
	
	function new(string name = "env_config");
		super.new(name);
		if(has_user_agent)
			user_agent_config_h      = user_agent_config::type_id::create("user_agent_config_h");
		if(has_admin_agent)
			admin_agent_config_h     = admin_agent_config::type_id::create("admin_agent_config_h");
		if(has_register_agent)
			register_agent_config_h  = register_agent_config::type_id::create("register_agent_config_h");
		if(has_emergency_agent)
			emergency_agent_config_h = emergency_agent_config::type_id::create("emergency_agent_config_h");
	endfunction: new
	
endclass
`endif

