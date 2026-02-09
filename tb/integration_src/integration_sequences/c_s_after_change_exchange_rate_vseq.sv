`ifndef CLIENT_SESSION_AFTER_CHANGE_EXCHANGE_RATE_VSEQ
`define CLIENT_SESSION_AFTER_CHANGE_EXCHANGE_RATE_VSEQ
class client_session_after_change_exchange_rate_vseq extends integration_base_virtual_seq #(
    .REGISTER_SEQ (change_exchange_rate_seq),
    .USER_SEQ     (full_client_session_with_no_errors_seq #(10)),
    .REPEAT_BODY  (3)
);

    `uvm_object_utils(client_session_after_change_exchange_rate_vseq)
    
    function new(string name = "client_session_after_change_exchange_rate_vseq");
        super.new(name);
    endfunction

endclass
`endif