`ifndef ERRORS_BASE_TEST
`define ERRORS_BASE_TEST

virtual class errors_base_test #(
    type ERRORS_SEQUENCE_TYPE
) extends stimulus_base_test #(
    .SEQUENCE_TYPE(ERRORS_SEQUENCE_TYPE),
    .IS_VIRTUAL_SEQUENCE(1)
);
    `uvm_component_param_utils(errors_base_test #(ERRORS_SEQUENCE_TYPE));
    
    function new(string name = "errors_base_test", uvm_component parent);
        super.new(name, parent);
    endfunction
    
endclass
`endif