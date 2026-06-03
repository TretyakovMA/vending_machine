`ifndef CLIENT_SESSION_AFTER_CHANGE_EXCHANGE_RATE_TEST
`define CLIENT_SESSION_AFTER_CHANGE_EXCHANGE_RATE_TEST
class client_session_after_change_exchange_rate_test extends integration_base_test #(
    client_session_after_change_exchange_rate_vseq
);
    `uvm_component_utils(client_session_after_change_exchange_rate_test)

    function new(string name = "client_session_after_change_exchange_rate_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

endclass
`endif