`ifndef REGISTER_SCOREBOARD
`define REGISTER_SCOREBOARD
class register_scoreboard extends uvm_scoreboard;
	`uvm_component_utils(register_scoreboard)

	uvm_analysis_imp #(register_transaction, register_scoreboard) a_imp;
	register_transaction exp_tr;
	vm_reg_block reg_block_h;
	
	bit[31:0] result;
	
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		a_imp = new("a_imp", this);
	endfunction: build_phase
	
	
	
	function void write (register_transaction t);
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