`ifndef ADMIN_MODE_ON_SEQ
`define ADMIN_MODE_ON_SEQ
class admin_mode_on_seq extends uvm_sequence #(admin_transaction);
	`uvm_object_utils(admin_mode_on_seq)

	bit [31:0]         admin_password;
	admin_transaction  tr;
    
	function new(string name = "admin_mode_on_seq");
		super.new(name);
	endfunction
    
	task body();
		tr = admin_transaction::type_id::create("tr");
		start_item(tr);
			
		tr.admin_password = admin_password; //Пароль должен быть получен из внешнего источника
		tr.admin_mode     = 1;
			
		finish_item(tr);
	endtask
endclass
`endif