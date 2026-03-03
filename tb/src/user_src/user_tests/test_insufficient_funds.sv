`ifndef TEST_INSUFFICIENT_FUNDS
`define TEST_INSUFFICIENT_FUNDS

class test_insufficient_funds extends user_base_test#(
    insufficient_funds_seq
);

	`uvm_component_utils(test_insufficient_funds)

	function new(string name = "test_insufficient_funds", uvm_component parent = null);
		super.new(name, parent);
	endfunction

endclass
`endif