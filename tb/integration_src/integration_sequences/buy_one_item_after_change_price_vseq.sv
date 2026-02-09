`ifndef BUY_ONE_ITEM_AFTER_CHANGE_PRICE_VSEQ
`define BUY_ONE_ITEM_AFTER_CHANGE_PRICE_VSEQ
class buy_one_item_after_change_price_vseq extends integration_base_virtual_seq #(
    .REGISTER_SEQ (change_item_price_seq),
    .USER_SEQ     (buy_one_item_seq     )
);

    `uvm_object_utils(buy_one_item_after_change_price_vseq)
    
    function new(string name = "buy_one_item_after_change_price_vseq");
        super.new(name);
    endfunction

endclass
`endif