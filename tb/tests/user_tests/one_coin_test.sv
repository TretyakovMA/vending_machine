`ifndef ONE_COIN_TEST
`define ONE_COIN_TEST
class one_coin_test extends user_base_test #(
	one_coin_seq
);
	`uvm_component_utils(one_coin_test)
	
	function new(string name = "one_coin_test", uvm_component parent);
		super.new(name, parent);
	endfunction
	
endclass
`endif