`ifndef CHECK_ALARM_TEST
`define CHECK_ALARM_TEST

class check_alarm_test extends sequence_base_test #(
    .SEQUENCE_TYPE      (activate_error_signals_seq         ),
    .SEQUENCER_TYPE     (error_sequencer                   ),
    .IS_VIRTUAL_SEQUENCE(0                                  ),
    .PATH_TO_SEQUENCER  ("*env_h.error_agent_h.sequencer_h")
);
    `uvm_component_utils(check_alarm_test);
    
    function new(string name = "check_alarm_test", uvm_component parent);
        super.new(name, parent);
    endfunction
    
endclass
`endif