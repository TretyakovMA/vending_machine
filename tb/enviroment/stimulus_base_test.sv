`ifndef STIMULUS_BASE_TEST
`define STIMULUS_BASE_TEST

virtual class stimulus_base_test #(
    type   SEQUENCE_TYPE,
    type   SEQUENCER_TYPE      = uvm_sequencer #(uvm_sequence_item),
    bit    IS_VIRTUAL_SEQUENCE = 1,
    string PATH_TO_SEQUENCER   = "virtual sequence don't use this"
) extends base_test;

    `uvm_component_param_utils(stimulus_base_test #(
        SEQUENCE_TYPE,
        SEQUENCER_TYPE,
        IS_VIRTUAL_SEQUENCE,
        PATH_TO_SEQUENCER
        )
    );

    SEQUENCE_TYPE  sequence_h;
    SEQUENCER_TYPE sequencer_h = null;
    uvm_component  component_h;
    

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new
    
    
    task main_phase(uvm_phase phase);
        if (!IS_VIRTUAL_SEQUENCE) begin
            component_h = uvm_top.find(PATH_TO_SEQUENCER);
            if(component_h == null)
                `uvm_fatal (get_type_name(), $sformatf("Failed to get sequencer from path: %s", PATH_TO_SEQUENCER))
            if(!$cast(sequencer_h, component_h))
                `uvm_fatal (get_type_name(), $sformatf("Failed to cast: component_h -> sequencer_h, path: %s", PATH_TO_SEQUENCER))
        end

        
        sequence_h = SEQUENCE_TYPE::type_id::create("sequence_h");
        
        sequence_h.set_starting_phase(phase);
		sequence_h.set_automatic_phase_objection(1);
        
        sequence_h.start(sequencer_h);
        
    endtask: main_phase

endclass
`endif