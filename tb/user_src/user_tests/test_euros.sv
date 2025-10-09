`ifndef TEST_EUROS
`define TEST_EUROS
class test_euros extends user_base_test #(
	test_euros_seq
);
	`uvm_component_utils(test_euros)
	
	function new(string name = "test_euros", uvm_component parent);
		super.new(name, parent);
	endfunction
	
endclass
`endif