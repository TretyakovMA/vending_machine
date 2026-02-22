`ifndef TEST_LOTS_OF_PURCHASES
`define TEST_LOTS_OF_PURCHASES
class test_lots_of_purchases extends user_base_test #(
	lots_of_purchases_seq
);
	`uvm_component_utils(test_lots_of_purchases)
	
	function new(string name = "test_lots_of_purchases", uvm_component parent);
		super.new(name, parent);
	endfunction
	
endclass
`endif