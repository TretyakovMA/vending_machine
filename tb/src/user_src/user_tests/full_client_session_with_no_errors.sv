`ifndef FULL_CLIENT_SESSION_WITH_NO_ERRORS
`define FULL_CLIENT_SESSION_WITH_NO_ERRORS
class full_client_session_with_no_errors extends user_base_test #(
	full_client_session_with_no_errors_seq
);
	`uvm_component_utils(full_client_session_with_no_errors)
	
	function new(string name = "full_client_session_with_no_errors", uvm_component parent);
		super.new(name, parent);
	endfunction
	
endclass
`endif