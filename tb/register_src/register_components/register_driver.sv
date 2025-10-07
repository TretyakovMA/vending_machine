`ifndef REGISTER_DRIVER
`define REGISTER_DRIVER
class register_driver extends base_driver #(
	virtual register_interface, 
	register_transaction
);

	`uvm_component_utils(register_driver)
	vm_reg_block reg_block_h;
	

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		if (!uvm_config_db #(vm_reg_block)::get(this, "", "reg_block_h", reg_block_h))
			`uvm_fatal(get_type_name(), "Failed to get reg_model")
	endfunction: connect_phase
	

	
	virtual task reset();
		reg_block_h.reset();
		vif.regs_data_in <= 0;
		vif.regs_addr    <= 0;
		vif.regs_we      <= 0;
	endtask: reset
	
	virtual task drive_transaction (register_transaction tr);
		vif.regs_addr <= tr.regs_addr;
		vif.regs_data_in <= tr.regs_data_in;
		vif.regs_we <= tr.regs_we;
		
		@(posedge vif.clk);
		if (!tr.regs_we) tr.regs_data_out = vif.regs_data_out;
	endtask: drive_transaction

endclass
`endif