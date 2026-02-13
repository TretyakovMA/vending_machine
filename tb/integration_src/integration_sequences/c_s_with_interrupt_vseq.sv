`ifndef CLIENT_SESSION_WITH_INTERRUPT_VSEQ
`define CLIENT_SESSION_WITH_INTERRUPT_VSEQ
class client_session_with_interrupt_vseq extends integration_base_virtual_seq #(
    .USER_SEQ      (full_client_session_with_no_errors_seq #(10)),
    .ERROR_SEQ     (activate_error_signals_seq                  )
);

    `uvm_object_utils(client_session_with_interrupt_vseq)
    
    function new(string name = "client_session_with_interrupt_vseq");
        super.new(name);
    endfunction

endclass
`endif