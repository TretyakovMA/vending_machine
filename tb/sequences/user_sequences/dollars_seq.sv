`ifndef DOLLARS_SEQ
`define DOLLARS_SEQ
class dollars_seq extends user_base_seq;
	`uvm_object_utils(dollars_seq)
    
	function new(string name = "dollars_seq");
		super.new(name);
	endfunction
    

	function void apply_constraints(user_transaction tr);
        assert(tr.randomize() with{
			coin_in_q.size() < 10;
			foreach(currency_type_q[i])
				currency_type_q[i] == USD;
		});
    endfunction: apply_constraints

endclass
`endif