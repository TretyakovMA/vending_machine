`ifndef CLIENT_SESSION_WITH_RESET_VSEQ
`define CLIENT_SESSION_WITH_RESET_VSEQ
class client_session_with_reset_vseq extends integration_base_virtual_seq #(
    .USER_SEQ      (client_session_without_errors_seq #(2)),
    .RESET_SEQ     (activate_reset_seq)
);

    `uvm_object_utils(client_session_with_reset_vseq)
    
    function new(string name = "client_session_with_reset_vseq");
        super.new(name);
    endfunction

endclass
`endif