`ifndef REGISTER_MONITOR
`define REGISTER_MONITOR
class register_monitor extends base_monitor #(
	virtual register_interface, 
	register_transaction
);

	`uvm_component_utils(register_monitor)
	vm_reg_block reg_block_h;
	
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new
	

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		if (!uvm_config_db #(vm_reg_block)::get(this, "", "reg_block_h", reg_block_h))
			`uvm_fatal(get_type_name(), "Failed to get reg_model")
	endfunction: connect_phase
	
	
	task monitoring_transaction (register_transaction tr);
		tr.regs_we = vif.regs_we;
		tr.regs_addr = vif.regs_addr;
		tr.regs_data_in = vif.regs_data_in;
		tr.regs_data_out = vif.regs_data_out;
	endtask: monitoring_transaction

	function bit condition ();
		return vif.regs_data_out != 32'hdead_beef;
	endfunction: condition

	task reset();
		reg_block_h.reset();
	endtask: reset
	
endclass
`endif