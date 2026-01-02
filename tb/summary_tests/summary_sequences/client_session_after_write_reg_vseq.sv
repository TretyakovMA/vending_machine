`ifndef CLIENT_SESSION_AFTER_WRITE_REG_VSEQ
`define CLIENT_SESSION_AFTER_WRITE_REG_VSEQ
class client_session_after_write_reg_vseq extends summary_base_vseq;

    `uvm_object_utils(client_session_after_write_reg_vseq)

    `define N 10

    register_test_vseq #(write_random_reg_seq)   reg_test_vseq;
    full_client_session_with_no_errors_seq #(`N) user_test_seq;
    
    function new(string name = "client_session_after_write_reg_vseq");
        super.new(name);
    endfunction

    task body();
        super.body();
        
        
        reg_test_vseq = register_test_vseq #(write_random_reg_seq)::type_id::create("reg_test_vseq");
        user_test_seq = full_client_session_with_no_errors_seq #(`N)::type_id::create("user_test_seq");

        repeat (10) begin
            if ($urandom_range(1))
                reg_test_vseq.start(null);
            else
                user_test_seq.start(user_sequencer_h);
        end
       
    endtask: body

endclass
`endif