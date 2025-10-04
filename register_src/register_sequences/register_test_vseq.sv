`ifndef REGISTER_TEST_VSEQ
`define REGISTER_TEST_VSEQ
class register_test_vseq extends uvm_reg_sequence;
	`uvm_object_utils(register_test_vseq)
    
	function new(string name = "register_test_vseq");
		super.new(name);
	endfunction
    
    admin_mode_on_seq    admin_mode_on_h;
    reset_test_seq       reg_seq_h;
    uvm_component        component_h;
    admin_sequencer      admin_sequencer_h;
    register_sequencer   register_sequencer_h;

	uvm_reg registers[$];
    register_transaction tr;
	vm_reg_block         reg_block_h;
	uvm_status_e         status;
	uvm_reg_data_t       value;
	bit                  up;
	
	task body();
		
		$cast(reg_block_h, model);
		//reg_block_h.reset();
		//reg_block_h.get_registers(registers);
		
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

            admin_mode_on_h = admin_mode_on_seq::type_id::create("admin_mode_on_h");
            reg_seq_h       = reset_test_seq::type_id::create("reg_seq_h");

            reg_seq_h.model = model; 


            admin_mode_on_h.start(admin_sequencer_h);
            reg_seq_h.start(register_sequencer_h);

			/*reg_block_h.print();
			
			foreach(registers[i]) begin
				
				assert (registers[i].randomize());
				value = registers[i].get();
				write_reg(registers[i], status, value);
				if (status != UVM_IS_OK)
					`uvm_fatal("sequence", "UVM_IS_NOT_OK")
			end	
			reg_block_h.print();
			foreach(registers[i]) begin
				//read_reg(registers[i], status, value);
				value = registers[i].get_mirrored_value();
				
				mirror_reg(registers[i], status, UVM_CHECK);
				registers[i].predict(value);
				if (status != UVM_IS_OK)
					`uvm_fatal("sequence", "UVM_IS_NOT_OK")
			end
			reg_block_h.print();*/
		end
	endtask
	
endclass
`endif