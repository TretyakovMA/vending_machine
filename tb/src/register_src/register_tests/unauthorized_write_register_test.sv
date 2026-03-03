`ifndef UNAUTORIZED_WRITE_REGISTER_TEST
`define UNAUTORIZED_WRITE_REGISTER_TEST
class unauthorized_write_register_test extends register_base_test #(
    unauthorized_write_register_seq
);
    `uvm_component_utils(unauthorized_write_register_test)

    function new(string name = "unauthorized_write_register_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

endclass
`endif