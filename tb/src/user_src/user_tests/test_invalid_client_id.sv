`ifndef TEST_INVALID_CLIENT_ID
`define TEST_INVALID_CLIENT_ID
class test_invalid_client_id extends user_base_test #(
	invalid_client_id_seq
);
	`uvm_component_utils(test_invalid_client_id)
	
	function new(string name = "test_invalid_client_id", uvm_component parent);
		super.new(name, parent);
    endfunction

endclass
`endif