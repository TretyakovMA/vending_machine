`ifndef CLIENT_SESSION_WITHOUT_ERRORS_TEST
`define CLIENT_SESSION_WITHOUT_ERRORS_TEST
class client_session_without_errors_test extends user_base_test #(
	client_session_without_errors_seq
);
	`uvm_component_utils(client_session_without_errors_test)
	
	function new(string name = "client_session_without_errors_test", uvm_component parent);
		super.new(name, parent);
	endfunction
	
endclass
`endif