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


	task _wait_for_reset_deassert_();
		@(posedge vif.clk iff vif.rst_n == 1);
	endtask: _wait_for_reset_deassert_

	task _wait_for_reset_assert_();
		@(negedge vif.rst_n);
	endtask: _wait_for_reset_assert_

	
	
	task _reset_();
		vif.admin_mode     <= 0;
		vif.admin_password <= 0;
	endtask: _reset_
	
	task _drive_transaction_(admin_transaction tr);
		vif.admin_mode     <= tr.admin_mode;
		vif.admin_password <= tr.admin_password;
		`uvm_info(get_type_name(), {"Send transaction: ", tr.convert2string()}, UVM_MEDIUM)
		
		@(posedge vif.clk);
	endtask: _drive_transaction_
	
endclass
`endif