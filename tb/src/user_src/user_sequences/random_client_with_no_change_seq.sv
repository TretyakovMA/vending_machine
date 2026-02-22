`ifndef RANDOM_CLIENTS_WITH_NO_CHANGE_SEQ
`define RANDOM_CLIENTS_WITH_NO_CHANGE_SEQ
class random_client_with_no_change_seq extends user_base_seq #(
	.NUMBER_OF_TESTS   (5    ),
	.NUMBER_OF_ATTEMPTS(10000)
);
	`uvm_object_utils(random_client_with_no_change_seq)
    
	function new(string name = "random_client_with_no_change_seq");
		super.new(name);
	endfunction

	function bit check_success(user_transaction exp_tr);
        return (exp_tr.change_out[31] == 0) && (exp_tr.no_change == 1);
    endfunction: check_success
	
endclass
`endif