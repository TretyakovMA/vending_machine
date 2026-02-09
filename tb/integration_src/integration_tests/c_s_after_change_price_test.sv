`ifndef CLIENT_SESSION_AFTER_CHANGE_PRICE_TEST
`define CLIENT_SESSION_AFTER_CHANGE_PRICE_TEST
class client_session_after_change_price_test extends integration_base_test #(
    client_session_after_change_price_vseq
);
    `uvm_component_utils(client_session_after_change_price_test)

    function new(string name = "buy_one_item_after_change_price_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

endclass
`endif