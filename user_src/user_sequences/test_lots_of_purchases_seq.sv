`ifndef TEST_LOTS_OF_PURCHASES_SEQ
`define TEST_LOTS_OF_PURCHASES_SEQ
class test_lots_of_purchases_seq extends uvm_sequence #(user_transaction);
	`uvm_object_utils(test_lots_of_purchases_seq)
    
	function new(string name = "test_lots_of_purchases_seq");
		super.new(name);
	endfunction
    
	task body();
		user_transaction tr;
		
		repeat(20) begin
			tr = user_transaction::type_id::create("tr");
			start_item(tr);
			`uvm_info("TEST", s_start, UVM_LOW)
			assert(tr.randomize() with {
				client_id == 3;
				coin_in_q.size() == 2;
				coin_in_q[0] == 25;
				coin_in_q[1] == 25;
				currency_type_q[0] == RUB;
				currency_type_q[1] == RUB;
				item_num == 1; 
			});
			
			finish_item(tr);
		end
	endtask
	
	
	string s_start = "\n\n\n\n\n\n\n\n##########################################   Start   #########################################";
endclass
`endif