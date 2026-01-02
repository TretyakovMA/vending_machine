`ifndef ERRORS_BASE_VSEQ
`define ERRORS_BASE_VSEQ

class errors_base_vseq extends uvm_sequence #(uvm_sequence_item);
    `uvm_object_utils(errors_base_vseq)

    uvm_component        component_h;
    user_sequencer       user_sequencer_h;
    errors_sequencer     errors_sequencer_h;

    function new(string name = "errors_base_vseq");
        super.new(name);
    endfunction: new

    task body();
        component_h = uvm_top.find("*env_h.user_agent_h.sequencer_h");
        if(component_h == null)
            `uvm_fatal (get_type_name(), "Failed to get user_sequencer")
        if(!$cast(user_sequencer_h, component_h))
            `uvm_fatal (get_type_name(), "Failed to cast: component_h -> user_sequencer_h")

        component_h = uvm_top.find("*env_h.errors_agent_h.sequencer_h");
        if(component_h == null)
            `uvm_fatal (get_type_name(), "Failed to get errors_sequencer")
        if(!$cast(errors_sequencer_h, component_h))
            `uvm_fatal (get_type_name(), "Failed to cast: component_h -> errors_sequencer_h")


    endtask: body
endclass
`endif