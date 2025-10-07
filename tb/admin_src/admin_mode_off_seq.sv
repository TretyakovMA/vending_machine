`ifndef ADMIN_MODE_OFF_SEQ
`define ADMIN_MODE_OFF_SEQ
class admin_mode_off_seq extends uvm_sequence #(admin_transaction);
	`uvm_object_utils(admin_mode_off_seq)

	admin_transaction tr;
    
	function new(string name = "admin_mode_off_seq");
		super.new(name);
	endfunction
    
	task body();
		tr = admin_transaction::type_id::create("tr");
		start_item(tr);
			
		tr.admin_password = 'h0;
		tr.admin_mode     = 0;
			
		finish_item(tr);
	endtask
endclass
`endif