`ifndef REGISTER_TEST
`define REGISTER_TEST
class register_test extends base_test;
	`uvm_component_utils(register_test)

    admin_mode_on_seq    a_seq;
    admin_mode_off_seq   admin_mode_off;
	vm_reg_block         reg_block_h;
	uvm_status_e         status;
	uvm_reg_data_t       value;
	reset_test_seq       r_seq;

    register_test_vseq   vseq;
	
	function new(string name = "register_test", uvm_component parent);
		super.new(name, parent);
	endfunction
	
	function uvm_sequence #(user_transaction) get_sequence();
        return null;
    endfunction
	

	task main_phase(uvm_phase phase);
        vseq  = register_test_vseq::type_id::create("vseq");
		//a_seq = admin_mode_on_seq::type_id::create("a_seq");
		//r_seq = reset_test_seq::type_id::create("r_seq");
		admin_mode_off = admin_mode_off_seq::type_id::create("admin_mode_off");

		//a_seq.set_starting_phase(phase);
        vseq.set_starting_phase(phase);
		//r_seq.set_starting_phase(phase);
    	admin_mode_off.set_starting_phase(phase);
		
		if(!uvm_config_db #(vm_reg_block)::get(this, "", "reg_block_h", reg_block_h))
			`uvm_fatal("RESET_TEST", "Faild to get reg_block_h")
		
		
		
		vseq.model = reg_block_h;
		//r_seq.model = reg_block_h;


		//a_seq.set_automatic_phase_objection(1);
        vseq.set_automatic_phase_objection(1);
		//r_seq.set_automatic_phase_objection(1);
		admin_mode_off.set_automatic_phase_objection(1);
		
		//a_seq.start(env_h.admin_agent_h.sequencer_h);
        vseq.start(null);
		//r_seq.start(env_h.register_agent_h.sequencer_h);
		admin_mode_off.start(env_h.admin_agent_h.sequencer_h);
		
	endtask: main_phase
endclass
`endif