`ifndef TEST_LOTS_OF_PURCHASES_SEQ
`define TEST_LOTS_OF_PURCHASES_SEQ
class test_lots_of_purchases_seq extends user_base_seq #(2);
	`uvm_object_utils(test_lots_of_purchases_seq)
    
	function new(string name = "test_lots_of_purchases_seq");
		super.new(name);
	endfunction

	virtual function void apply_constraints(user_transaction tr);
        assert(tr.randomize() with{
			client_id          == 3;
			coin_in_q.size()   == 2;
			coin_in_q[0]       == 25;
			coin_in_q[1]       == 25;
			currency_type_q[0] == RUB;
			currency_type_q[1] == EUR;
			item_num           == 4; 
		});
    endfunction: apply_constraints

	
    
endclass
`endif