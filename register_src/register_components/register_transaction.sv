`ifndef REGISTER_TRANSACTION
`define REGISTER_TRANSACTION
class register_transaction extends uvm_sequence_item;
	`uvm_object_utils(register_transaction)
	rand bit [31:0] regs_data_in;
	rand bit [7:0] regs_addr;
	rand bit regs_we;
	
	bit [31:0] regs_data_out;
	
	function new(string name = "register_transaction");
		super.new(name);
	endfunction: new
	
	
	function string convert2string();
		string s;
		s = $sformatf("Regs_data_in = %h; Regs_addr = %h; regs_we = %b Regs_data_out = %h",
			regs_data_in, regs_addr, regs_we, regs_data_out);
		return s;
	endfunction: convert2string
	
	
	function void do_copy(uvm_object rhs);
		register_transaction copied_tr;
		
		if(rhs == null)
			`uvm_fatal("REGISTER_TRANSACTION", "Tried to copy from a null pointer")
		if(!$cast(copied_tr, rhs))
			`uvm_fatal("REGISTER_TRANSACTION", "Tried to copy wrong type")
		
		super.do_copy(rhs);
		
		this.regs_data_in  = copied_tr.regs_data_in;
		this.regs_addr     = copied_tr.regs_addr;
		this.regs_we       = copied_tr.regs_we;
		this.regs_data_out = copied_tr.regs_data_out;
		
	endfunction: do_copy
	
	
	function register_transaction clone_me();
		register_transaction clone;
		uvm_object tmp;
		
		tmp = this.clone();
		$cast(clone, tmp);
		return clone;
	endfunction: clone_me
	
endclass
`endif