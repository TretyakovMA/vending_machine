`ifndef ADMIN_DRIVER
`define ADMIN_DRIVER
class admin_driver extends base_driver #(
	.INTERFACE_TYPE   (virtual admin_interface), 
	.TRANSACTION_TYPE (admin_transaction      )
);
	`uvm_component_utils(admin_driver)
	

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new

	
	
	task reset();
		vif.admin_mode     <= 0;
		vif.admin_password <= 0;
	endtask: reset
	
	task drive_transaction(admin_transaction tr);
		vif.admin_mode     <= tr.admin_mode;
		vif.admin_password <= tr.admin_password;
		wait_for_active_clock();
	endtask: drive_transaction
	
endclass
`endif