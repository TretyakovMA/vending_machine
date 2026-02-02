`ifndef REGISTER_BASE_TEST
`define REGISTER_BASE_TEST
virtual class register_base_test #(
    type REGISTER_SEQUENCE_TYPE
) extends sequence_base_test #(
    .SEQUENCE_TYPE(register_test_vseq #(REGISTER_SEQUENCE_TYPE)),
    .IS_VIRTUAL_SEQUENCE(1)
);
    `uvm_component_param_utils(register_base_test #(REGISTER_SEQUENCE_TYPE));
    

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new
    
endclass
`endif