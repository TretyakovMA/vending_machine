`ifndef TEST_RANDOM_CLIENTS_WITH_NO_CHANGE
`define TEST_RANDOM_CLIENTS_WITH_NO_CHANGE
class test_random_client_with_no_change extends user_base_test #(
	random_client_with_no_change_seq
);
	`uvm_component_utils(test_random_client_with_no_change)
	
	function new(string name = "test_random_client_with_no_change", uvm_component parent);
		super.new(name, parent);
	endfunction
	
endclass
`endif