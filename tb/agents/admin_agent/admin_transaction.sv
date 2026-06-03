`ifndef ADMIN_TRANSACTION
`define ADMIN_TRANSACTION
class admin_transaction extends uvm_sequence_item;
	`uvm_object_utils(admin_transaction)
	
	
	bit [31:0] admin_password;
	bit        admin_mode;
	
	function new(string name = "admin_transaction");
		super.new(name);
	endfunction: new

	function string convert2string();
		string s;
		s = $sformatf("Admin_password = %h; Admin_mode = %b",
			admin_password, admin_mode);
		return s;
	endfunction: convert2string
	
endclass
`endif
