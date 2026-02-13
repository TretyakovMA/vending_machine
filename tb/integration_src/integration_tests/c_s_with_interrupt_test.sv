`ifndef CLIENT_SESSION_WITH_INTERRUPT_TEST
`define CLIENT_SESSION_WITH_INTERRUPT_TEST
class client_session_with_interrupt_test extends integration_base_test #(
    client_session_with_interrupt_vseq
);
    `uvm_component_utils(client_session_with_interrupt_test)

    function new(string name = "client_session_with_interrupt_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

endclass
`endif