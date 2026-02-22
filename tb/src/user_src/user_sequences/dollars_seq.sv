`ifndef DOLLARS_SEQ
`define DOLLARS_SEQ
class dollars_seq extends user_base_seq;
	`uvm_object_utils(dollars_seq)
    
	function new(string name = "dollars_seq");
		super.new(name);
	endfunction
    

	function void apply_constraints(user_transaction tr);
        assert(tr.randomize() with{
			client_id          == 3;
			coin_in_q.size()   == 1;
			coin_in_q[0]       == 25;
			currency_type_q[0] == USD;
			item_num           == 1; 
		});
    endfunction: apply_constraints

endclass
`endif