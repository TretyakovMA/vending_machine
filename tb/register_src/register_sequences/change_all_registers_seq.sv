`ifndef CHANGE_ALL_REGISTERS_SEQ
`define CHANGE_ALL_REGISTERS_SEQ  
class change_all_registers_seq extends register_base_seq;
    `uvm_object_utils(change_all_registers_seq)

    
    function new(string name = "change_all_registers_seq");
        super.new(name);
    endfunction
    
    
    
    task body();
        super.body();
        
        registers.shuffle();
        
        foreach (registers[i]) begin
            write_random_value(registers[i]);
        end
        reg_block_h.print();
    endtask: body
endclass
`endif