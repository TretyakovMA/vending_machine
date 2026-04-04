`ifndef CHECK_ALARM_TEST
`define CHECK_ALARM_TEST

class check_alarm_test extends sequence_base_test #(
    .SEQUENCE_TYPE      (activate_emergency_signals_seq),
    .SEQUENCER_TYPE     (emergency_sequencer           ),
    .IS_VIRTUAL_SEQUENCE(0                             ),
    .PARENT_TYPE        (base_test                     )
);
    `uvm_component_utils(check_alarm_test);
    
    function new(string name = "check_alarm_test", uvm_component parent);
        super.new(name, parent);
    endfunction

    function string get_sequencer_name();
        return "emergency_sequencer";
    endfunction: get_sequencer_name

    function void adjust_env_config();
        env_config_h.has_user_agent      = 0;      
        env_config_h.has_admin_agent     = 0;
        env_config_h.has_register_agent  = 0;
        env_config_h.has_emergency_agent = 1; 

        env_config_h.has_register_env    = 0;  
    endfunction: adjust_env_config

    // Если не добавить эту задержку, то монитор не успеет
    // заметить изменение сигналов ошибок и тест не пройдет
    function int set_drain_time();
        return 10; //10 нс
    endfunction: set_drain_time
    
endclass
`endif