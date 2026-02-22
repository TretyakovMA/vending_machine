`ifndef BUY_ONE_ITEM_SEQ
`define BUY_ONE_ITEM_SEQ
class buy_one_item_seq extends user_base_seq;
	`uvm_object_utils(buy_one_item_seq)
    
	function new(string name = "buy_one_item_seq");
		super.new(name);
	endfunction
    

	function void apply_constraints(user_transaction tr);
        assert(tr.randomize() with{
            coin_in_q.size() == 3; 
		});
    endfunction: apply_constraints

endclass
`endif