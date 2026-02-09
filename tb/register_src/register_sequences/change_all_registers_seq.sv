`ifndef CHANGE_ALL_REGISTERS_SEQ
`define CHANGE_ALL_REGISTERS_SEQ  
class change_all_registers_seq extends register_base_seq;
    `uvm_object_utils(change_all_registers_seq)

    
    function new(string name = "change_all_registers_seq");
        super.new(name);
    endfunction
    
    
    
    task body();
        super.body();
        
        foreach (reg_block_h.vend_item[i]) begin //В будущем это нужно удалить
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