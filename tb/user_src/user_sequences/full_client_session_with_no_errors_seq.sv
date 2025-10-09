`ifndef FULL_CLIENT_SESSION_WITH_NO_ERRORS_SEQ
`define FULL_CLIENT_SESSION_WITH_NO_ERRORS_SEQ
class full_client_session_with_no_errors_seq extends user_base_seq #(
	.NUMBER_OF_TESTS (1000)
);
	`uvm_object_utils(full_client_session_with_no_errors_seq)
    
	function new(string name = "full_client_session_with_no_errors_seq");
		super.new(name);
	endfunction
	
endclass
`endif