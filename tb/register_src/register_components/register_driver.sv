`ifndef REGISTER_DRIVER
`define REGISTER_DRIVER
class register_driver extends base_driver #(
	virtual register_interface, 
	register_transaction
);

	`uvm_component_utils(register_driver)
	

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new

	
	virtual task reset();
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