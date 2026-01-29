`ifndef REGISTER_MONITOR
`define REGISTER_MONITOR
class register_monitor extends base_monitor #(
	virtual register_interface, 
	register_transaction
);

	`uvm_component_utils(register_monitor)
	
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new
	


	function bit should_start_monitoring ();
		return (vif.regs_data_out != 32'hdead_beef) && (vif.rst_n == 1);
	endfunction: should_start_monitoring

	task collect_transaction_data (register_transaction tr);
		tr.regs_we       = vif.regs_we;
		tr.regs_addr     = vif.regs_addr;
		tr.regs_data_in  = vif.regs_data_in;
		tr.regs_data_out = vif.regs_data_out;
	endtask: collect_transaction_data

endclass
`endif