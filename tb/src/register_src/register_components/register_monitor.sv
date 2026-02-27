`ifndef REGISTER_MONITOR
`define REGISTER_MONITOR
class register_monitor extends vm_base_monitor #(
	.INTERFACE_TYPE   (virtual register_interface), 
	.TRANSACTION_TYPE (register_transaction      )
);

	`uvm_component_utils(register_monitor)
	
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new
	



	task _wait_for_sampling_event_(); 
        @(posedge vif.clk iff vif.regs_data_out != 32'hdead_beef);
    endtask: _wait_for_sampling_event_

	task _collect_transaction_data_ (register_transaction tr);
		tr.regs_we       = vif.regs_we;
		tr.regs_addr     = vif.regs_addr;
		tr.regs_data_in  = vif.regs_data_in;
		tr.regs_data_out = vif.regs_data_out;
	endtask: _collect_transaction_data_

endclass
`endif