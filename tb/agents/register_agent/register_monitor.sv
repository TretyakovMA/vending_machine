`ifndef REGISTER_MONITOR
`define REGISTER_MONITOR
class register_monitor extends base_monitor #(
	.INTERFACE_TYPE   (virtual register_interface), 
	.TRANSACTION_TYPE (register_transaction      )
);

	`uvm_component_utils(register_monitor)
	
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new



	task _wait_for_reset_deassert_();
		@(posedge vif.clk iff vif.rst_n == 1);
	endtask: _wait_for_reset_deassert_

	task _wait_for_reset_assert_();
		@(negedge vif.rst_n);
	endtask: _wait_for_reset_assert_



	virtual task _wait_for_sampling_event_(); 
		@(posedge vif.clk iff vif.regs_data_out != 32'hdeadbeef);
    endtask: _wait_for_sampling_event_

	virtual task _collect_transaction_data_ (register_transaction tr);
		tr.regs_we       = vif.regs_we;
		tr.regs_addr     = vif.regs_addr;
		tr.regs_data_in  = vif.regs_data_in;
		tr.regs_data_out = vif.regs_data_out;

		tr.access_error  = vif.access_error;
	endtask: _collect_transaction_data_

endclass
`endif