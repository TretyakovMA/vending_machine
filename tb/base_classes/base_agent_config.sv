`ifndef BASE_AGENT_CONFIG
`define BASE_AGENT_CONFIG
class base_agent_config #(type INTERFACE_TYPE) extends uvm_object;
	`uvm_object_param_utils(base_agent_config #(INTERFACE_TYPE))
	INTERFACE_TYPE vif;
	uvm_active_passive_enum is_active = UVM_ACTIVE;
	bit has_monitor;
	function new(string name = "");
		super.new(name);
	endfunction
	
endclass
`endif