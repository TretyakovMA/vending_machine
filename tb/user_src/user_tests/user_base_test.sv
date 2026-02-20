`ifndef USER_BASE_TEST
`define USER_BASE_TEST

virtual class user_base_test #(
    type USER_SEQUENCE_TYPE
) extends sequence_base_test #(
    .SEQUENCE_TYPE      (USER_SEQUENCE_TYPE),
    .SEQUENCER_TYPE     (user_sequencer    ),
    .IS_VIRTUAL_SEQUENCE(0                 )
);
    `uvm_component_param_utils(user_base_test #(USER_SEQUENCE_TYPE));
    
    function new(string name = "user_base_test", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function string get_sequencer_name();
        return "user_sequencer";
    endfunction: get_sequencer_name

    function void adjust_env_config();
        env_config_h.has_user_agent      = 1;      
        env_config_h.has_admin_agent     = 0;
        env_config_h.has_register_agent  = 0;
        env_config_h.has_emergency_agent = 0; 

        env_config_h.has_register_env    = 1;  
    endfunction: adjust_env_config
    
endclass
`endif