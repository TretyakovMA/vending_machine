`ifndef ENV_CONFIG
`define ENV_CONFIG
class env_config extends uvm_object;
	`uvm_object_utils(env_config)

	user_agent_config     user_agent_config_h;
	admin_agent_config    admin_agent_config_h;
	register_agent_config register_agent_config_h;
	error_agent_config    error_agent_config_h;
	
	function new(string name = "env_config");
		super.new(name);
	endfunction: new
	
endclass
`endif

