`ifndef TEST_FEW_COIN_SEQ
`define TEST_FEW_COIN_SEQ
class test_few_coin_seq extends uvm_sequence #(user_transaction);
	`uvm_object_utils(test_few_coin_seq)
    
	function new(string name = "test_few_coin_seq");
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
				coin_in_q.size() == 20;
				foreach (coin_in_q[i])
					coin_in_q[i] == 1;
				foreach (currency_type_q[i])
					currency_type_q[i] == RUB;
				
				item_num == 1; 
			});
			
			finish_item(tr);
		end
	endtask
	
	
	string s_start = "\n\n\n\n\n\n\n\n##########################################   Start   #########################################";
endclass
`endif