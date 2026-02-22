`ifndef INITIATOR
`define INITIATOR

class initiator extends sequence_base_test #(
    .SEQUENCE_TYPE      (initial_reset_seq),
    .SEQUENCER_TYPE     (reset_sequencer  ),
    .IS_VIRTUAL_SEQUENCE(0                ),
    .PARENT_TYPE        (uvm_component    )
);

    `uvm_component_utils(initiator)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function string get_sequencer_name();
        return "reset_sequencer";
    endfunction: get_sequencer_name


endclass
`endif