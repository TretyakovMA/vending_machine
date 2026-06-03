`ifndef INVALID_CLIENT_ID_TEST
`define INVALID_CLIENT_ID_TEST
class invalid_client_id_test extends user_base_test #(
	invalid_client_id_seq
);
	`uvm_component_utils(invalid_client_id_test)
	
	function new(string name = "invalid_client_id_test", uvm_component parent);
		super.new(name, parent);
    endfunction

endclass
`endif