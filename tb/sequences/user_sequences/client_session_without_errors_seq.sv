`ifndef CLIENT_SESSION_WITHOUT_NO_ERRORS_SEQ
`define CLIENT_SESSION_WITHOUT_NO_ERRORS_SEQ
class client_session_without_errors_seq #(N = 100) extends user_base_seq #(
	.NUMBER_OF_TESTS (N)
);
	`uvm_object_param_utils(client_session_without_errors_seq #(N))
    
	function new(string name = "client_session_without_errors_seq");
		super.new(name);
	endfunction

	
endclass
`endif