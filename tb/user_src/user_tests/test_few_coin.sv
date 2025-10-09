`ifndef TEST_FEW_COIN
`define TEST_FEW_COIN
class test_few_coin extends user_base_test #(
	test_few_coin_seq
);
	`uvm_component_utils(test_few_coin)
	
	function new(string name = "test_few_coin", uvm_component parent);
		super.new(name, parent);
	endfunction
	
	
endclass
`endif