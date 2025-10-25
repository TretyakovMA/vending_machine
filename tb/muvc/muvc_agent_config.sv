`ifndef MUVC_AGENT_CONFIG
`define MUVC_AGENT_CONFIG
class muvc_agent_config #(
	type INTERFACE_TYPE
) extends uvm_object;

	`uvm_object_param_utils(muvc_agent_config #(INTERFACE_TYPE))
	INTERFACE_TYPE          vif;
	uvm_active_passive_enum is_active = UVM_ACTIVE;
	bit                     has_monitor;
	
	function new(string name = "muvc_agent_config");
		super.new(name);
	endfunction
	
endclass
`endif