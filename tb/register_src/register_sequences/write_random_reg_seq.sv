`ifndef WRITE_RANDOM_REG_SEQ
`define WRITE_RANDOM_REG_SEQ  
class write_random_reg_seq extends base_reg_seq;
    `uvm_object_utils(write_random_reg_seq)

    
    function new(string name = "write_random_reg_seq");
        super.new(name);
    endfunction
    
    
    
    task body();
        super.body();
        
        foreach (reg_block_h.vend_item[i]) begin
            reg_block_h.vend_item[i].item_discount.rand_mode(0);
        end
        
        registers.shuffle();
        foreach (registers[i]) begin
            assert (registers[i].randomize());
			value = registers[i].get();
			write_reg(registers[i], status, value);
        end
        reg_block_h.print();
    endtask: body
endclass
`endif