`ifndef REGISTER_BASE_TEST
`define REGISTER_BASE_TEST
//Данный класс запускает register_base_virtual_seq
//с указанной регистровой последовательностью в качестве параметра типа
virtual class register_base_test #(
    type REGISTER_SEQUENCE_TYPE
) extends sequence_base_test #(
    .SEQUENCE_TYPE(register_base_virtual_seq #(REGISTER_SEQUENCE_TYPE)),
    .IS_VIRTUAL_SEQUENCE(1)
);
    `uvm_component_param_utils(register_base_test #(REGISTER_SEQUENCE_TYPE));
    

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void adjust_config();
        env_config_h.has_user_agent     = 0;      
        env_config_h.has_admin_agent    = 1;
        env_config_h.has_register_agent = 1;
        env_config_h.has_error_agent    = 0; 

        env_config_h.has_register_env   = 1;  
    endfunction: adjust_config
    
endclass
`endif