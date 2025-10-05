`ifndef USER_AGENT
`define USER_AGENT
class user_agent extends base_agent #(
	virtual user_interface, 
	user_transaction, 
	user_driver, 
	user_monitor
);
	`uvm_component_utils(user_agent);
	
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction
	
endclass
`endif
