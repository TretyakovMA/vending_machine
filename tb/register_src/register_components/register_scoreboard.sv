`ifndef REGISTER_SCOREBOARD
`define REGISTER_SCOREBOARD
class register_scoreboard extends uvm_scoreboard;
	`uvm_component_utils(register_scoreboard)

	uvm_analysis_imp #(register_transaction, register_scoreboard) a_imp;
	
	local vm_reg_block     reg_block_h;
	
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		a_imp = new("a_imp", this);
	endfunction: build_phase
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		if(!uvm_config_db #(vm_reg_block)::get(this, "", "reg_block", reg_block_h))
			`uvm_fatal(get_type_name(), "Failed to get reg_block")
	endfunction: connect_phase

	task reset_phase(uvm_phase phase);
		super.reset_phase(phase);
		reg_block_h.reset();
	endtask: reset_phase
	
	/*task check_registers();
		foreach(registers[i])begin
			mirrored_value = registers[i].get_mirrored_value();
			registers[i].peek(status, value);
			if(value != mirrored_value) begin
				`uvm_error(get_type_name(), $sformatf("Register %s mismatch: expected 0x%0h, got 0x%0h", registers[i].get_name(), mirrored_value, value))
				registers[i].predict(mirrored_value);
			end
			else begin
				`uvm_info(get_type_name(), $sformatf("Register %s match: value 0x%0h", registers[i].get_name(), value), UVM_HIGH)
			end
		end
	endtask: check_registers*/
	
	function void write (register_transaction t);
		if(t.has_reset) begin
			`uvm_info(get_type_name(), "Reset detected", UVM_HIGH)
			reg_block_h.reset();
			return;
		end

		//if(t.regs_we == 0) begin
			
			/*uvm_reg rg;
			uvm_reg_data_t mirrored_value;
			rg = reg_block_h.reg_map.get_reg_by_offset(t.regs_addr);
			`uvm_info("SCOREBOARD", {"Get transaction: ", t.convert2string()}, UVM_LOW)
			//mirrored_value = rg.get_mirrored_value();
			mirrored_value = rg.get();
			//rg.print();
			//result = reg_block_h.vend_item[1].get_mirrored_value();
			`uvm_info("SCOREBOARD", $sformatf("value = %h\n\n\n\n\n", mirrored_value), UVM_LOW)
			if (t.regs_data_out != mirrored_value)
				`uvm_error("SCOREBOARD", {"Transaction: ", t.convert2string, $sformatf(" Expect = %h", mirrored_value), "\n\n\n"})
			reg_block_h.print();*/
		//end
	endfunction: write
	
endclass
`endif