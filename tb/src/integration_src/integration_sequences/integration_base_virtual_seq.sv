`ifndef INTEGRATION_BASE_VSEQ
`define INTEGRATION_BASE_VSEQ

class integration_base_virtual_seq #(
    type REGISTER_SEQ  = register_base_seq,
    type USER_SEQ      = void_sequence,
    type EMERGENCY_SEQ = void_sequence,
    type RESET_SEQ     = void_sequence,
    int  REPEAT_BODY   = 1
) extends uvm_sequence #(uvm_sequence_item);

    `uvm_object_param_utils(integration_base_virtual_seq #(
        REGISTER_SEQ, 
        USER_SEQ, 
        EMERGENCY_SEQ, 
        RESET_SEQ,
        REPEAT_BODY
        )
    )

    protected user_sequencer      user_sequencer_h;
    protected emergency_sequencer emergency_sequencer_h;
    protected reset_sequencer     reset_sequencer_h;
    
    local bit register_vseq_created = 0;
    local bit user_seq_created      = 0;
    local bit emergency_seq_created = 0;
    local bit reset_seq_created     = 0;

    register_base_virtual_seq #(REGISTER_SEQ) register_vseq;
    USER_SEQ                                  user_seq;
    EMERGENCY_SEQ                             emergency_seq;
    RESET_SEQ                                 reset_seq;

    

    function new(string name = "integration_base_virtual_seq");
        super.new(name);
    endfunction: new


    // Функция получения секвенсеров и создания последовательностей
    virtual function void create_body();
        if (USER_SEQ::type_name != "void_sequence") begin
        
            if (!uvm_config_db #(user_sequencer)::get(null, "", "user_sequencer", user_sequencer_h))
                `uvm_fatal(get_type_name(), "Failed to get user_sequencer from config_db");

            user_seq = USER_SEQ::type_id::create("user_seq");
            user_seq_created = 1;
        end

        if (EMERGENCY_SEQ::type_name != "void_sequence") begin

            if (!uvm_config_db #(emergency_sequencer)::get(null, "", "emergency_sequencer", emergency_sequencer_h))
                `uvm_fatal(get_type_name(), "Failed to get emergency_sequencer from config_db");

            emergency_seq = EMERGENCY_SEQ::type_id::create("emergency_seq");
            emergency_seq_created = 1;
        end
        
        if (REGISTER_SEQ::type_name != "register_base_seq") begin
            register_vseq = register_base_virtual_seq #(REGISTER_SEQ)::type_id::create("register_vseq");
            register_vseq_created = 1;
        end

        if(RESET_SEQ::type_name != "void_sequence") begin
            if(!uvm_config_db #(reset_sequencer)::get(null, "", "reset_sequencer", reset_sequencer_h))
                `uvm_fatal(get_type_name(), "Failed to get reset_sequencer from config_db");
            
            reset_seq = RESET_SEQ::type_id::create("reset_seq");
            reset_seq_created = 1;
        end
    endfunction: create_body



    // Задача body по умолчанию
    virtual task main_body();
        repeat (REPEAT_BODY) fork

            if(emergency_seq_created) 
                emergency_seq.start(emergency_sequencer_h);
            
            if(reset_seq_created)
                reset_seq.start(reset_sequencer_h);
            
            begin
                if(register_vseq_created)
                    register_vseq.start(null);
                if(user_seq_created)
                    user_seq.start(user_sequencer_h);
            end

        join
    endtask: main_body



    // Основная задача
    virtual task body();
        create_body();
        main_body();
    endtask: body
endclass
`endif