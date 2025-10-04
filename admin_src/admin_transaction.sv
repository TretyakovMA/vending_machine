`ifndef ADMIN_TRANSACTION
`define ADMIN_TRANSACTION
class admin_transaction extends uvm_sequence_item;
	`uvm_object_utils(admin_transaction)
	
	
	bit [31:0] admin_password;
	bit        admin_mode;
	
	function new(string name = "admin_transaction");
		super.new(name);
	endfunction: new
	
endclass
`endif
