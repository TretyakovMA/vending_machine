`ifndef INVALID_PASSWORD_CHANGE_TEST
`define INVALID_PASSWORD_CHANGE_TEST

class invalid_password_change_test extends register_base_test #(
    invalid_password_change_seq
);
    `uvm_component_utils(invalid_password_change_test)

    function new(string name = "invalid_password_change_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

endclass
`endif