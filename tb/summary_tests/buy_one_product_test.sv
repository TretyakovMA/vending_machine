`ifndef BUY_ONE_PRODUCT_TEST
`define BUY_ONE_PRODUCT_TEST

class buy_one_product_test extends summary_base_test #(
    buy_one_product_vseq
);
    `uvm_component_utils(buy_one_product_test)


    function new(string name = "buy_one_product_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

endclass
`endif