`ifndef POWER_LOSS_VSEQ
`define POWER_LOSS_VSEQ
class power_loss_vseq extends errors_base_vseq;

    `uvm_object_utils(power_loss_vseq)

    power_loss_seq                              errors_seq;
    full_client_session_with_no_errors_seq #(5) user_test_seq;
    
    function new(string name = "power_loss_vseq");
        super.new(name);
    endfunction

    task body();
        super.body();
        
        errors_seq    = power_loss_seq::type_id::create("errors_seq");
        user_test_seq = full_client_session_with_no_errors_seq #(5)::type_id::create("user_test_seq");

        
        fork 
            errors_seq.start(errors_sequencer_h);
            user_test_seq.start(user_sequencer_h);
        join_any

    endtask: body

endclass
`endif