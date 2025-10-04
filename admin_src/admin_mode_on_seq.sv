`ifndef ADMIN_MODE_ON_SEQ
`define ADMIN_MODE_ON_SEQ
class admin_mode_on_seq extends uvm_sequence #(admin_transaction);
	`uvm_object_utils(admin_mode_on_seq)
    
	function new(string name = "admin_mode_on_seq");
		super.new(name);
	endfunction
    
	task body();
		admin_transaction tr;
		
		repeat(1) begin
			tr = admin_transaction::type_id::create("tr");
			start_item(tr);
			
			tr.admin_password = 32'hA5A5_F00D;
			tr.admin_mode     = 1;
			
			finish_item(tr);
		end
	endtask
endclass
`endif