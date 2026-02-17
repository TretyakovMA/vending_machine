`ifndef CHECK_READ_SEQ
`define CHECK_READ_SEQ
class check_read_seq extends register_base_seq;
    `uvm_object_utils(check_read_seq)

	function new(string name = "check_read_seq");
		super.new(name);
	endfunction
    
    
    task body();
        super.body();
        
        repeat(1) begin
            reg_block_h.print();
            
            foreach(registers[i]) begin
				write_random_value(registers[i]);
			end	
            
            reg_block_h.print();
            registers.shuffle();

            foreach(registers[i]) begin
                mirrored_value = registers[i].get_mirrored_value();

                mirror_reg(registers[i], status, UVM_CHECK);
                
                if(mirrored_value != registers[i].get_mirrored_value()) begin
                    void '(registers[i].predict(mirrored_value));
                end
            end

            reg_block_h.print();
        end
    endtask

endclass
`endif