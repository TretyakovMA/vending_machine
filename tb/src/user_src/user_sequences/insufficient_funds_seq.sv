`ifndef INSUFFICIENT_FUNDS_SEQ
`define INSUFFICIENT_FUNDS_SEQ

class insufficient_funds_seq extends user_base_seq;
	`uvm_object_utils(insufficient_funds_seq)

	function new(string name = "insufficient_funds_seq");
		super.new(name);
	endfunction

    function bit check_success(user_transaction exp_tr);
        return exp_tr.change_out[31] == 1;
    endfunction: check_success
    
endclass
`endif