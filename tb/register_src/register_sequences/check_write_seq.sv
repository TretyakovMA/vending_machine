`ifndef CHECK_WRITE_SEQ
`define CHECK_WRITE_SEQ
class check_write_seq extends register_base_seq;
	`uvm_object_utils(check_write_seq)

	function new(string name = "check_write_seq");
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
			end	

			#1;
			check_registers();
			reg_block_h.print();
		end
	endtask
	
endclass
`endif