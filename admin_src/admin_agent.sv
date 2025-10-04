`ifndef ADMIN_AGENT
`define ADMIN_AGENT
class admin_agent extends base_agent #(
								virtual admin_interface, 
								admin_transaction, 
								admin_driver
								);
	`uvm_component_utils(admin_agent);
	
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction
	
	
endclass
`endif
