`ifndef TEST_ONE_COIN
`define TEST_ONE_COIN
class test_one_coin extends user_base_test #(
	test_one_coin_seq
);
	`uvm_component_utils(test_one_coin)
	
	function new(string name = "test_one_coin", uvm_component parent);
		super.new(name, parent);
	endfunction
	
endclass
`endif