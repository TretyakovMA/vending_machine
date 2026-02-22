`ifndef BUY_ONE_ITEM_AFTER_CHANGE_PRICE_TEST
`define BUY_ONE_ITEM_AFTER_CHANGE_PRICE_TEST

class buy_one_item_after_change_price_test extends integration_base_test #(
    buy_one_item_after_change_price_vseq
);
    `uvm_component_utils(buy_one_item_after_change_price_test)


    function new(string name = "buy_one_item_after_change_price_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

endclass
`endif