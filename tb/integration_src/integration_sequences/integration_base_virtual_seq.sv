`ifndef INTEGRATION_BASE_VSEQ
`define INTEGRATION_BASE_VSEQ

class integration_base_virtual_seq #(
    type REGISTER_SEQ  = register_base_seq,
    type USER_SEQ      = void_sequence,
    type ERROR_SEQ     = void_sequence,
    int  REPEAT_BODY   = 1
) extends uvm_sequence #(uvm_sequence_item);

    `uvm_object_param_utils(integration_base_virtual_seq #(
        REGISTER_SEQ, 
        USER_SEQ, 
        ERROR_SEQ, 
        REPEAT_BODY
        )
    )

    local uvm_component        component_h;
    protected user_sequencer   user_sequencer_h;
    protected error_sequencer  error_sequencer_h;
    
    local bit                  reg_vseq_created  = 0;
    local bit                  user_seq_created  = 0;
    local bit                  error_seq_created = 0;

    register_base_virtual_seq #(REGISTER_SEQ) reg_vseq;
    USER_SEQ                                  user_seq;
    activate_error_signals_seq                error_seq;
    

    function new(string name = "integration_base_virtual_seq");
        super.new(name);
    endfunction: new



    virtual function void create_body();
        if (USER_SEQ::type_name != "void_sequence") begin
            component_h = uvm_top.find("*env_h.user_agent_h.sequencer_h");
            if(component_h == null)
                `uvm_fatal (get_type_name(), "Failed to get user_sequencer")
            if(!$cast(user_sequencer_h, component_h))
                `uvm_fatal (get_type_name(), "Failed to cast: component_h -> user_sequencer_h")

            user_seq = USER_SEQ::type_id::create("user_seq");
            user_seq_created = 1;
        end

        if (ERROR_SEQ::type_name != "void_sequence") begin
            component_h = uvm_top.find("*env_h.error_agent_h.sequencer_h");
            if(component_h == null)
                `uvm_fatal (get_type_name(), "Failed to get error_sequencer")
            if(!$cast(error_sequencer_h, component_h))
                `uvm_fatal (get_type_name(), "Failed to cast: component_h -> error_sequencer_h")

            error_seq = activate_error_signals_seq::type_id::create("error_seq");
            error_seq_created = 1;
        end
        
        if (REGISTER_SEQ::type_name != "register_base_seq") begin
            reg_vseq = register_base_virtual_seq #(REGISTER_SEQ)::type_id::create("reg_vseq");
            reg_vseq_created = 1;
        end
    endfunction: create_body



    task main_body_without_error_seq();
        if(reg_vseq_created)
            reg_vseq.start(null);
        if(user_seq_created)
            user_seq.start(user_sequencer_h);
    endtask: main_body_without_error_seq

    task main_body_with_error_seq();
        fork
            error_seq.start(error_sequencer_h);
            main_body_without_error_seq();
        join
    endtask: main_body_with_error_seq



    virtual task main_body();
        repeat (REPEAT_BODY) begin
            if (error_seq_created) 
                main_body_with_error_seq();
            else
                main_body_without_error_seq();
        end
    endtask: main_body



    virtual task body();
        create_body();
        main_body();
    endtask: body
endclass
`endif