`ifndef ENV_CONFIG
`define ENV_CONFIG
class env_config extends uvm_object;
	`uvm_object_utils(env_config)

	agent_config #(virtual user_interface) user_agent_config_h;
	agent_config #(virtual admin_interface) admin_agent_config_h;
	agent_config #(virtual register_interface) register_agent_config_h;

	
	function new(string name = "");
		super.new(name);
	endfunction
	
endclass
`endif

