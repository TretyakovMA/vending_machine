`ifndef TEST_DOLLARS
`define TEST_DOLLARS
class test_dollars extends user_base_test #(
	dollars_seq
);
	`uvm_component_utils(test_dollars)
	
	function new(string name = "test_dollars", uvm_component parent);
		super.new(name, parent);
	endfunction
	
endclass
`endif