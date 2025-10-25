`ifndef REGISTER_AGENT
`define REGISTER_AGENT
class register_agent extends muvc_agent #(
	.INTERFACE_TYPE   (virtual register_interface), 
	.TRANSACTION_TYPE (register_transaction), 
	.DRIVER_TYPE      (register_driver), 
	.MONITOR_TYPE     (register_monitor)
);

	`uvm_component_utils(register_agent);
	
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction
	
endclass
`endif
