`ifndef BUY_FOR_EUROS_AFTER_CHANGE_EXCHANGE_RATE_TEST
`define BUY_FOR_EUROS_AFTER_CHANGE_EXCHANGE_RATE_TEST

class buy_for_euros_after_change_exchange_rate_test extends integration_base_test #(
    buy_for_euros_after_change_exchange_rate_vseq
);
    `uvm_component_utils(buy_for_euros_after_change_exchange_rate_test)

    function new(string name = "buy_for_euros_after_change_exchange_rate_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

endclass
`endif