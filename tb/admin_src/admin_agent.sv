`ifndef ADMIN_AGENT
`define ADMIN_AGENT
class admin_agent extends muvc_agent #(
	.INTERFACE_TYPE   (virtual admin_interface), 
	.TRANSACTION_TYPE (admin_transaction), 
	.DRIVER_TYPE      (admin_driver)
);
	`uvm_component_utils(admin_agent);
	
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction
	
endclass
`endif
