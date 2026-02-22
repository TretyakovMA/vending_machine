`ifndef FULL_CLIENT_SESSION_WITH_NO_ERRORS_SEQ
`define FULL_CLIENT_SESSION_WITH_NO_ERRORS_SEQ
class full_client_session_with_no_errors_seq #(N = 100) extends user_base_seq #(
	.NUMBER_OF_TESTS (N)
);
	`uvm_object_param_utils(full_client_session_with_no_errors_seq #(N))
    
	function new(string name = "full_client_session_with_no_errors_seq");
		super.new(name);
	endfunction

	
endclass
`endif