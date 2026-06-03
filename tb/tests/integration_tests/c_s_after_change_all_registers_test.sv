`ifndef CLIENT_SESSION_AFTER_CHANGE_ALL_REGISTERS_TEST
`define CLIENT_SESSION_AFTER_CHANGE_ALL_REGISTERS_TEST

class client_session_after_change_all_registers_test extends integration_base_test #(
    client_session_after_change_all_registers_vseq
);
    `uvm_component_utils(client_session_after_change_all_registers_test)

    function new(string name = "client_session_after_change_all_registers_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

endclass
`endif