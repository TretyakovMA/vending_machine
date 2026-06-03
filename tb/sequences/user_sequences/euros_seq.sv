`ifndef EUROS_SEQ
`define EUROS_SEQ
class euros_seq extends user_base_seq;
	`uvm_object_utils(euros_seq)
    
	function new(string name = "euros_seq");
		super.new(name);
	endfunction

	function void apply_constraints(user_transaction tr);
        assert(tr.randomize() with{
			coin_in_q.size() < 10;
			foreach(currency_type_q[i])
				currency_type_q[i] == EUR;
		});
    endfunction: apply_constraints
    
	
endclass
`endif