`ifndef CHECK_ALARM_TEST
`define CHECK_ALARM_TEST

class check_alarm_test extends sequence_base_test #(
    .SEQUENCE_TYPE      (activate_emergency_signals_seq),
    .SEQUENCER_TYPE     (emergency_sequencer           ),
    .IS_VIRTUAL_SEQUENCE(0                             )
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

    function void create_callbacks(); 
        emergency_driver driver_h;
        delay_after_alarm_test_cb cb;

        if (!uvm_config_db #(emergency_driver)::get(this, "", "emergency_driver", driver_h))
            `uvm_fatal(get_type_name(), "Failed to get emergency driver from config_db")
        
        
        cb = delay_after_alarm_test_cb::type_id::create("cb");

        uvm_callbacks#(emergency_driver, emergency_driver_cb)::add(driver_h, cb);

	endfunction: create_callbacks
    
endclass
`endif