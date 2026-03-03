`ifndef WRITE_REGISTERS_WITH_INVALID_PASSWORD_TEST
`define WRITE_REGISTERS_WITH_INVALID_PASSWORD_TEST

class write_registers_with_invalid_password_test extends register_base_test #(
    write_registers_with_invalid_password_seq
);

    `uvm_component_utils(write_registers_with_invalid_password_test)

    function new(string name = "write_registers_with_invalid_password_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

endclass
`endif