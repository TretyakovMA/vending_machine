`ifndef CLIENT_SESSION_AFTER_CHANGE_DISCOUNT_VSEQ
`define CLIENT_SESSION_AFTER_CHANGE_DISCOUNT_VSEQ
class client_session_after_change_discount_vseq extends integration_base_virtual_seq #(
    .REGISTER_SEQ (change_item_discount_seq),
    .USER_SEQ     (full_client_session_with_no_errors_seq #(10)),
    .REPEAT_BODY  (1)
);

    `uvm_object_utils(client_session_after_change_discount_vseq)
    
    function new(string name = "client_session_after_change_discount_vseq");
        super.new(name);
    endfunction

endclass
`endif