`ifndef FEW_COIN_SEQ
`define FEW_COIN_SEQ
class few_coin_seq extends user_base_seq;
	`uvm_object_utils(few_coin_seq)
    
	function new(string name = "few_coin_seq");
		super.new(name);
	endfunction

	function void apply_constraints(user_transaction tr);
        assert(tr.randomize() with{
			client_id          == 3;
			coin_in_q.size()   == 20;
			item_num           == 1;
			foreach (coin_in_q[i])
				coin_in_q[i] == 1;
			foreach (currency_type_q[i])
				currency_type_q[i] == RUB;
		});
    endfunction: apply_constraints
	
endclass
`endif