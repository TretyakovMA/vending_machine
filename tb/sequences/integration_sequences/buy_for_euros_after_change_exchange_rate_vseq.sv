`ifndef BUY_FOR_EUROS_AFTER_CHANGE_EXCHANGE_RATE_VSEQ
`define BUY_FOR_EUROS_AFTER_CHANGE_EXCHANGE_RATE_VSEQ

class buy_for_euros_after_change_exchange_rate_vseq extends integration_base_virtual_seq #(
    .REGISTER_SEQ (change_exchange_rate_seq),
    .USER_SEQ     (euros_seq)
);
    `uvm_object_utils(buy_for_euros_after_change_exchange_rate_vseq)

    function new(string name = "buy_for_euros_after_change_exchange_rate_vseq");
        super.new(name);
    endfunction

endclass
`endif