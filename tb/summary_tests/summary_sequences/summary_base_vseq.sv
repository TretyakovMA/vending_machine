`ifndef SUMMARY_BASE_VSEQ
`define SUMMARY_BASE_VSEQ

class summary_base_vseq extends uvm_sequence #(uvm_sequence_item);
    `uvm_object_utils(summary_base_vseq)

    uvm_component        component_h;
    user_sequencer       user_sequencer_h;

    function new(string name = "summary_base_vseq");
        super.new(name);
    endfunction: new

    task body();
        component_h = uvm_top.find("*env_h.user_agent_h.sequencer_h");
        if(component_h == null)
            `uvm_fatal (get_type_name(), "Failed to get user_sequencer")
        if(!$cast(user_sequencer_h, component_h))
            `uvm_fatal (get_type_name(), "Failed to cast: component_h -> user_sequencer_h")

    endtask: body
endclass
`endif