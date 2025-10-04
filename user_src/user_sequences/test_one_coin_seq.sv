`ifndef TEST_ONE_COIN_SEQ
`define TEST_ONE_COIN_SEQ
class test_one_coin_seq extends uvm_sequence #(user_transaction);
	`uvm_object_utils(test_one_coin_seq)
    
	function new(string name = "test_one_coin_seq");
		super.new(name);
	endfunction
    
	task body();
		user_transaction tr;
		
		repeat(1) begin
			tr = user_transaction::type_id::create("tr");
			start_item(tr);
			`uvm_info("TEST", s_start, UVM_LOW)
			assert(tr.randomize() with {
				client_id == 3;
				coin_in_q.size() == 1;
				coin_in_q[0] == 25;
				currency_type_q[0] == RUB;
				item_num == 1; 
			});
			
			finish_item(tr);
		end
	endtask
	
	
	string s_start = "\n\n\n\n\n\n\n\n##########################################   Start   #########################################";
endclass
`endif