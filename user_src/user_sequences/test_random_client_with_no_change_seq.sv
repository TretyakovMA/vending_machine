`ifndef TEST_RANDOM_CLIENTS_WITH_NO_CHANGE_SEQ
`define TEST_RANDOM_CLIENTS_WITH_NO_CHANGE_SEQ
class test_random_client_with_no_change_seq extends uvm_sequence #(user_transaction);
	`uvm_object_utils(test_random_client_with_no_change_seq)
    
	function new(string name = "test_random_client_with_no_change_seq");
		super.new(name);
	endfunction
    
	task body();
		user_transaction tr;
		
		repeat(1) begin
			tr = user_transaction::type_id::create("tr");
			start_item(tr);
			`uvm_info("TEST", s_start, UVM_LOW)
			assert(tr.randomize() with {
				foreach (currency_type_q[i])
					currency_type_q[i] == RUB;
				//calculate_balance(coin_in_q, currency_type_q) == get_item_price(item_num, client_id);
				//solve item_num, client_id before coin_in_q, currency_type_q;
			});
			
			finish_item(tr);
		end
	endtask
	
	
	string s_start = "\n\n\n\n\n\n\n\n##########################################   Start   #########################################";
endclass
`endif