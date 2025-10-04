`ifndef RESET_TEST_SEQ
`define RESET_TEST_SEQ
class reset_test_seq extends uvm_reg_sequence;
	`uvm_object_utils(reset_test_seq)
    
	function new(string name = "reset_test_seq");
		super.new(name);
	endfunction
    
	uvm_reg registers[$];
	
	task body();
		register_transaction tr;
		vm_reg_block         reg_block_h;
		uvm_status_e         status;
		uvm_reg_data_t       value;
		bit                  up;
		$cast(reg_block_h, model);
		reg_block_h.reset();
		reg_block_h.get_registers(registers);
		
		repeat(1) begin
			
			reg_block_h.print();
			
			foreach(registers[i]) begin
				
				assert (registers[i].randomize());
				value = registers[i].get();
				write_reg(registers[i], status, value);
				if (status != UVM_IS_OK)
					`uvm_fatal("sequence", "UVM_IS_NOT_OK")
			end	
			reg_block_h.print();
			foreach(registers[i]) begin
				//read_reg(registers[i], status, value);
				value = registers[i].get_mirrored_value();
				
				mirror_reg(registers[i], status, UVM_CHECK);
				registers[i].predict(value);
				if (status != UVM_IS_OK)
					`uvm_fatal("sequence", "UVM_IS_NOT_OK")
			end
			reg_block_h.print();
		end
	endtask
	
endclass
`endif