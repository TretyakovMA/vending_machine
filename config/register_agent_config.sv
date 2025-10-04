`ifndef REGISTER_AGENT_CONFIG
`define REGISTER_AGENT_CONFIG
class register_agent_config extends uvm_object;
	`uvm_object_utils(register_agent_config)
	
	//virtual register_interface vif;
	
	//uvm_active_passive_enum is_active = UVM_ACTIVE;
	//bit has_monitor;
	function new(string name = "");
		super.new(name);
	endfunction
	
endclass
`endif