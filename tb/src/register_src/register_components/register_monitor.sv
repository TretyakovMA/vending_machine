`ifndef REGISTER_MONITOR
`define REGISTER_MONITOR
class register_monitor extends vm_base_monitor #(
	.INTERFACE_TYPE   (virtual register_interface), 
	.TRANSACTION_TYPE (register_transaction      )
);

	bit need_deadbeef = 0;

	`uvm_component_utils(register_monitor)

	`uvm_register_cb(register_monitor, register_monitor_cb)
	
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new
	
	task configure_phase(uvm_phase phase);
		super.configure_phase(phase);
		`uvm_do_callbacks(register_monitor, register_monitor_cb, need_deadbeef_sensitive(need_deadbeef))
	endtask: configure_phase


	task _wait_for_sampling_event_(); 
        // Для теста unauthorized_write требуется, чтобы проверялись все сигналы, в том числе с deadbeef
		if(need_deadbeef)
			@(posedge vif.clk);
		// Остальные тесты игнорирую случай regs_data_out = deadbeef
		else
			@(posedge vif.clk iff vif.regs_data_out != 32'hdeadbeef);
    endtask: _wait_for_sampling_event_

	task _collect_transaction_data_ (register_transaction tr);
		tr.regs_we       = vif.regs_we;
		tr.regs_addr     = vif.regs_addr;
		tr.regs_data_in  = vif.regs_data_in;
		tr.regs_data_out = vif.regs_data_out;

		tr.access_error  = vif.access_error;
	endtask: _collect_transaction_data_

endclass
`endif