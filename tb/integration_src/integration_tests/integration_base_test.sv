`ifndef INTEGRATION_BASE_TEST
`define INTEGRATION_BASE_TEST
virtual class integration_base_test #(
    type INTEGRATION_SEQUENCE_TYPE
) extends sequence_base_test #(
    .SEQUENCE_TYPE      (INTEGRATION_SEQUENCE_TYPE),
    .IS_VIRTUAL_SEQUENCE(1)
);
    `uvm_component_param_utils(integration_base_test #(INTEGRATION_SEQUENCE_TYPE));
    

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void adjust_config();
        env_config_h.has_user_agent     = 1;      
        env_config_h.has_admin_agent    = 1;
        env_config_h.has_register_agent = 1;
        env_config_h.has_error_agent    = 1; 

        env_config_h.has_register_env   = 1;  
    endfunction: adjust_config
    
endclass
`endif