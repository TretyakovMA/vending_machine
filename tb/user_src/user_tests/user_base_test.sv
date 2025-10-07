`ifndef USER_BASE_TEST
`define USER_BASE_TEST

virtual class user_base_test #(
    type USER_SEQUENCE_TYPE
) extends stimulus_base_test #(
    .SEQUENCE_TYPE(USER_SEQUENCE_TYPE),
    .SEQUENCER_TYPE(user_sequencer),
    .IS_VIRTUAL_SEQUENCE(0),
    .PATH_TO_SEQUENCER("*env_h.user_agent_h.sequencer_h")
);
    `uvm_component_param_utils(user_base_test #(USER_SEQUENCE_TYPE));
    
    function new(string name = "user_base_test", uvm_component parent);
        super.new(name, parent);
    endfunction
    
endclass
`endif