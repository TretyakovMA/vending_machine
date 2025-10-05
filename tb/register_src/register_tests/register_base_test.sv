`ifndef REGISTER_BASE_TEST
`define REGISTER_BASE_TEST  
virtual class register_base_test #(
    type REG_TEST_SEQ
) extends base_test;
    `uvm_component_param_utils(register_base_test #(REG_TEST_SEQ));

    vm_reg_block   reg_block_h;
    register_test_vseq #(REG_TEST_SEQ) register_sequence_h;
    
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new
    
    
    
    task main_phase(uvm_phase phase);
        register_sequence_h = register_test_vseq #(REG_TEST_SEQ)::type_id::create("register_sequence_h");

        if(!uvm_config_db #(vm_reg_block)::get(this, "", "reg_block_h", reg_block_h))
			`uvm_fatal(get_type_name(), "Faild to get reg_block_h")
        
        register_sequence_h.model = reg_block_h;
        register_sequence_h.set_starting_phase(phase);
        register_sequence_h.set_automatic_phase_objection(1);
        register_sequence_h.start(null);
    endtask: main_phase
endclass
`endif