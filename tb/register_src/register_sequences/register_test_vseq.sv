`ifndef REGISTER_TEST_VSEQ
`define REGISTER_TEST_VSEQ
class register_test_vseq #(
    type REG_TEST_SEQ
) extends uvm_reg_sequence;
	`uvm_object_param_utils(register_test_vseq #(REG_TEST_SEQ))
    
	function new(string name = "register_test_vseq");
		super.new(name);
	endfunction
    
    admin_mode_on_seq    admin_mode_on_h;
    REG_TEST_SEQ         reg_seq_h;
	admin_mode_off_seq   admin_mode_off_h;

    uvm_component        component_h;
    admin_sequencer      admin_sequencer_h;
    register_sequencer   register_sequencer_h;

	uvm_reg              registers[$];
	vm_reg_block         reg_block_h;
	
	
	task body();
		
		$cast(reg_block_h, model);
		
		
		repeat(1) begin
            component_h = uvm_top.find("*env_h.admin_agent_h.sequencer_h");
            if(component_h == null)
                `uvm_fatal (get_type_name(), "Failed to get admin_sequencer")
            if(!$cast(admin_sequencer_h, component_h))
                `uvm_fatal (get_type_name(), "Failed to cast: component_h -> admin_sequencer_h")

            component_h = uvm_top.find("*env_h.register_agent_h.sequencer_h");
            if(component_h == null)
                `uvm_fatal (get_type_name(), "Failed to get register_sequencer")
            if(!$cast(register_sequencer_h, component_h))
                `uvm_fatal (get_type_name(), "Failed to cast: component_h -> register_sequencer_h")



            admin_mode_on_h  = admin_mode_on_seq::type_id::create("admin_mode_on_h");
            reg_seq_h        = REG_TEST_SEQ::type_id::create("reg_seq_h");
			admin_mode_off_h = admin_mode_off_seq::type_id::create("admin_mode_off_h");


            reg_seq_h.model = model; 


            admin_mode_on_h.start(admin_sequencer_h);
            reg_seq_h.start(register_sequencer_h);
			admin_mode_off_h.start(admin_sequencer_h);
		end
	endtask
	
endclass
`endif