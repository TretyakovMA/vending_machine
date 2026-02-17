`ifndef WRITE_REGISTERS_WITH_EMERGENCY_TEST
`define WRITE_REGISTERS_WITH_EMERGENCY_TEST
class write_registers_with_emergency_test extends integration_base_test #(
    write_registers_with_emergency_vseq
);
    `uvm_component_utils(write_registers_with_emergency_test)

    function new(string name = "write_registers_with_emergency_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

endclass
`endif