`ifndef SUMMARY_BASE_TEST
`define SUMMARY_BASE_TEST
virtual class summary_base_test #(
    type SUMMARY_SEQUENCE_TYPE
) extends stimulus_base_test #(
    .SEQUENCE_TYPE(SUMMARY_SEQUENCE_TYPE),
    .IS_VIRTUAL_SEQUENCE(1)
);
    `uvm_component_param_utils(summary_base_test #(SUMMARY_SEQUENCE_TYPE));
    

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new
    
endclass
`endif