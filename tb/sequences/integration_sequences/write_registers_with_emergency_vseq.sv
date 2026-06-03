`ifndef WRITE_REGISTERS_WITH_EMERGENCY_VSEQ
`define WRITE_REGISTERS_WITH_EMERGENCY_VSEQ

class write_registers_with_emergency_vseq extends integration_base_virtual_seq #(
    .REGISTER_SEQ  (write_registers_with_emergency_seq),
    .EMERGENCY_SEQ (activate_emergency_signals_seq    )
);

    `uvm_object_utils(write_registers_with_emergency_vseq)
    
    function new(string name = "write_registers_with_emergency_vseq");
        super.new(name);
    endfunction
endclass
`endif