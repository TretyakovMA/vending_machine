`ifndef CLIENT_SESSION_AFTER_WRITE_REG_TEST
`define CLIENT_SESSION_AFTER_WRITE_REG_TEST

class client_session_after_write_reg_test extends summary_base_test #(
    client_session_after_write_reg_vseq
);
    `uvm_component_utils(client_session_after_write_reg_test)


    function new(string name = "client_session_after_write_reg_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

endclass
`endif