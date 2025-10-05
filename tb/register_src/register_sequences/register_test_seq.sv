`ifndef REGISTER_TEST_SEQ
`define REGISTER_TEST_SEQ
class register_test_seq extends base_reg_seq;
	`uvm_object_utils(register_test_seq)

    
	function new(string name = "register_test_seq");
		super.new(name);
	endfunction
    
	
	
	task body();
		super.body();
		
		
		repeat(1) begin
			
			reg_block_h.print();
			
			foreach(registers[i]) begin
				assert (registers[i].randomize());
				value = registers[i].get();
				write_reg(registers[i], status, value);
				if (status != UVM_IS_OK)
					`uvm_fatal(get_type_name(), "UVM_IS_NOT_OK")
			end	
			reg_block_h.print();
			foreach(registers[i]) begin
				value = registers[i].get_mirrored_value();
				
				mirror_reg(registers[i], status, UVM_CHECK);

				if(value != registers[i].get_mirrored_value())
					registers[i].predict(value);
				
				if (status != UVM_IS_OK)
					`uvm_fatal(get_type_name(), "UVM_IS_NOT_OK")
			end
			reg_block_h.print();
		end
	endtask
	
endclass
`endif