`ifndef CLIENT_SESSION_WITH_EMERGENCY_TEST
`define CLIENT_SESSION_WITH_EMERGENCY_TEST
class client_session_with_emergency_test extends integration_base_test #(
    client_session_with_emergency_vseq
);
    `uvm_component_utils(client_session_with_emergency_test)

    function new(string name = "client_session_with_emergency_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

endclass
`endif