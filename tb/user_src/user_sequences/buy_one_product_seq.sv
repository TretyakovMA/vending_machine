`ifndef BUY_ONE_PRODUCT_SEQ
`define BUY_ONE_PRODUCT_SEQ
class buy_one_product_seq extends user_base_seq;
	`uvm_object_utils(buy_one_product_seq)
    
	function new(string name = "buy_one_product_seq");
		super.new(name);
	endfunction
    

	virtual function void apply_constraints(user_transaction tr);
        assert(tr.randomize() with{
            coin_in_q.size() == 3; 
		});
    endfunction: apply_constraints

endclass
`endif