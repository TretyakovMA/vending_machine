`ifndef SIMPLE_TEST_SEQ
`define SIMPLE_TEST_SEQ
class simple_test_seq extends uvm_sequence #(user_transaction);
	`uvm_object_utils(simple_test_seq)
    
	function new(string name = "simple_test_seq");
		super.new(name);
	endfunction
    
	task body();
		user_transaction tr;
		
		repeat(5) begin
			tr = user_transaction::type_id::create("tr");
			start_item(tr);
			`uvm_info("TEST", s_start, UVM_LOW)
			tr.client_id = 3; 
			tr.coin_in_q = {25, 10};
			tr.currency_type_q = {RUB, RUB};
			tr.item_num = 1;  
			
			finish_item(tr);
		end
	endtask
	
	
	string s_start = "\n\n\n\n\n\n\n\n##########################################   Start   #########################################";
endclass
`endif