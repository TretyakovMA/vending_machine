`ifndef EUROS_SEQ
`define EUROS_SEQ
class euros_seq extends user_base_seq;
	`uvm_object_utils(euros_seq)
    
	function new(string name = "euros_seq");
		super.new(name);
	endfunction

	function void apply_constraints(user_transaction tr);
        assert(tr.randomize() with{
			client_id          == 3;
			coin_in_q.size()   == 1;
			coin_in_q[0]       == 25;
			currency_type_q[0] == EUR;
			item_num           == 1; 
		});
    endfunction: apply_constraints
    
	
endclass
`endif