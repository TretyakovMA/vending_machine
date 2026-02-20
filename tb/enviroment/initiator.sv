`ifndef INITIATOR
`define INITIATOR

class initiator extends uvm_component;

    `uvm_component_utils(initiator)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    initial_reset_seq initial_reset_seq_h;
    reset_sequencer   reset_sequencer_h;

    function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);

         // Получение reset_sequencer
        if (!uvm_config_db #(reset_sequencer)::get(this, "", "reset_sequencer", reset_sequencer_h))
            `uvm_fatal(get_type_name(), "Failed to get reset sequencer from config_db");

    endfunction: connect_phase

    virtual task start_initial_seq (uvm_phase phase);

        // Создание и запуск последовательности для инициализации
        initial_reset_seq_h = initial_reset_seq::type_id::create("initial_reset_seq_h");

        `uvm_info(get_type_name(), "Starting initial reset sequence", UVM_HIGH);
        initial_reset_seq_h.set_starting_phase(phase);
        initial_reset_seq_h.set_automatic_phase_objection(1);
        initial_reset_seq_h.start(reset_sequencer_h);
    endtask: start_initial_seq

    task main_phase(uvm_phase phase);
        super.main_phase  (phase);
        start_initial_seq (phase);
    endtask: main_phase

endclass
`endif