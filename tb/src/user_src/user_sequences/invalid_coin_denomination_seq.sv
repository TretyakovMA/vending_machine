`ifndef INVALID_COIN_DENOMINATION_SEQ
`define INVALID_COIN_DENOMINATION_SEQ

class invalid_coin_denomination_seq extends user_base_seq;
	`uvm_object_utils(invalid_coin_denomination_seq)

	function new(string name = "invalid_coin_denomination_seq");
		super.new(name);
	endfunction

    function void apply_constraints(user_transaction tr);
        tr.valid_coin_denomination.constraint_mode(0);
        assert (tr.randomize());
    endfunction: apply_constraints
endclass
`endif