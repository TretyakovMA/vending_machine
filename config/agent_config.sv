`ifndef AGENT_CONFIG
`define AGENT_CONFIG
class agent_config #(type INTERFACE_TYPE) extends uvm_object;
	`uvm_object_param_utils(agent_config #(INTERFACE_TYPE))
	INTERFACE_TYPE vif;
	uvm_active_passive_enum is_active = UVM_ACTIVE;
	bit has_monitor;
	function new(string name = "");
		super.new(name);
	endfunction
	
endclass
`endif