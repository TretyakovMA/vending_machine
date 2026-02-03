`ifndef REGISTER_DRIVER
`define REGISTER_DRIVER
class register_driver extends base_driver #(
	.INTERFACE_TYPE   (virtual register_interface), 
	.TRANSACTION_TYPE (register_transaction      )
);

	`uvm_component_utils(register_driver)

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new

	

	task reset();
		vif.regs_data_in <= 0;
		vif.regs_addr    <= 0;
		vif.regs_we      <= 0;
	endtask: reset
	
	task drive_transaction (register_transaction tr);
		if (tr.regs_we)
			write(tr);
		else
			read(tr);

		reset();
	endtask: drive_transaction

	task read(register_transaction tr);
		vif.regs_addr    <= tr.regs_addr;
		vif.regs_we      <= 0;
		
		@(posedge vif.clk);
		tr.regs_data_out = vif.regs_data_out;
	endtask: read

	task write(register_transaction tr);
		vif.regs_addr    <= tr.regs_addr;
		vif.regs_data_in <= tr.regs_data_in;
		vif.regs_we      <= 1;
	endtask: write

endclass
`endif