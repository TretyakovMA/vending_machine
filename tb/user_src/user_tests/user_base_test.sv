`ifndef USER_BASE_TEST
`define USER_BASE_TEST

virtual class user_base_test extends base_test;
    `uvm_component_utils(user_base_test);
    
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new
    

    pure virtual function uvm_sequence #(user_transaction) get_sequence();

    
    
    task main_phase(uvm_phase phase);
        uvm_sequence #(user_transaction) user_sequence_h;
        user_sequence_h = get_sequence();
        if (user_sequence_h == null) begin
            `uvm_fatal(get_type_name(), "No sequence provided by the test")
        end
        user_sequence_h.set_starting_phase(phase);
		user_sequence_h.set_automatic_phase_objection(1);
        user_sequence_h.start(env_h.user_agent_h.sequencer_h);
    endtask: main_phase

    
endclass
`endif