`ifndef CHANGE_ITEM_DISCOUNT_SEQ
`define CHANGE_ITEM_DISCOUNT_SEQ  
class change_item_discount_seq extends register_base_seq;
    `uvm_object_utils(change_item_discount_seq)

    
    function new(string name = "change_item_discount_seq");
        super.new(name);
    endfunction
    
    
    
    task body();
        super.body();
        
        foreach (reg_block_h.vend_item[i]) begin
            reg_block_h.vend_item[i].item_price.rand_mode(0);
            reg_block_h.vend_item[i].item_count.rand_mode(0);
            
            write_random_value(reg_block_h.vend_item[i]);
        end
        reg_block_h.print();
    endtask: body
endclass
`endif