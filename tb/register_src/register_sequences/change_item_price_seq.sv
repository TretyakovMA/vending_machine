`ifndef CHANGE_ITEM_PRICE_SEQ
`define CHANGE_ITEM_PRICE_SEQ  
class change_item_price_seq extends base_reg_seq;
    `uvm_object_utils(change_item_price_seq)

    
    function new(string name = "change_item_price_seq");
        super.new(name);
    endfunction
    
    
    
    task body();
        super.body();
        
        foreach (reg_block_h.vend_item[i]) begin
            reg_block_h.vend_item[i].item_discount.rand_mode(0);
            reg_block_h.vend_item[i].item_count.rand_mode(0);
            assert (reg_block_h.vend_item[i].randomize());
            value = reg_block_h.vend_item[i].get();
            write_reg(reg_block_h.vend_item[i], status, value);
        end
        reg_block_h.print();
    endtask: body
endclass
`endif