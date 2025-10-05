`ifndef FULL_CLIENT_SESSION_WITH_NO_ERRORS_SEQ
`define FULL_CLIENT_SESSION_WITH_NO_ERRORS_SEQ
class full_client_session_with_no_errors_seq extends uvm_sequence #(user_transaction);
	`uvm_object_utils(full_client_session_with_no_errors_seq)
    
	function new(string name = "full_client_session_with_no_errors_seq");
		super.new(name);
	endfunction
    
	task body();
		user_transaction tr;
		
		repeat(100) begin
			tr = user_transaction::type_id::create("tr");
			start_item(tr);
			`uvm_info("TEST", s_start, UVM_LOW)
			assert(tr.randomize());
			
			finish_item(tr);
		end
	endtask
	
	
	string s_start = "\n\n\n\n\n\n\n\n##########################################   Start   #########################################";
endclass
`endif