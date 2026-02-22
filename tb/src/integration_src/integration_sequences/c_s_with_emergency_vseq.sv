`ifndef CLIENT_SESSION_WITH_EMERGENCY_VSEQ
`define CLIENT_SESSION_WITH_EMERGENCY_VSEQ
class client_session_with_emergency_vseq extends integration_base_virtual_seq #(
    .USER_SEQ      (full_client_session_with_no_errors_seq #(10)),
    .EMERGENCY_SEQ (activate_emergency_signals_seq              )
);

    `uvm_object_utils(client_session_with_emergency_vseq)
    
    function new(string name = "client_session_with_emergency_vseq");
        super.new(name);
    endfunction

endclass
`endif