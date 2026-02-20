`ifndef CLIENT_SESSION_WITH_RESET_VSEQ
`define CLIENT_SESSION_WITH_RESET_VSEQ
class client_session_with_reset_vseq extends integration_base_virtual_seq #(
    .USER_SEQ      (full_client_session_with_no_errors_seq #(2))
);

    `uvm_object_utils(client_session_with_reset_vseq)

    reset_sequencer reset_sequencer_h;
    reset_seq       reset_seq_h;
    
    
    function new(string name = "client_session_with_reset_vseq");
        super.new(name);
    endfunction

    function void create_body();
        super.create_body();

        if(!uvm_config_db #(reset_sequencer)::get(null, "", "reset_sequencer", reset_sequencer_h))
            `uvm_fatal(get_type_name(), "Failed to get reset_sequencer from config_db");
        
        reset_seq_h = reset_seq::type_id::create("reset_seq_h");
    endfunction: create_body

    task main_body();
        fork
            reset_seq_h.start(reset_sequencer_h);
            user_seq.start(user_sequencer_h);
        join
    endtask: main_body

endclass
`endif