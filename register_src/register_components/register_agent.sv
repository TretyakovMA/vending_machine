`ifndef REGISTER_AGENT
`define REGISTER_AGENT
class register_agent extends base_agent #(
								virtual register_interface, 
								register_transaction, 
								register_driver, 
								register_monitor
								);
	`uvm_component_utils(register_agent);
	
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction
	
	

	
endclass
`endif
