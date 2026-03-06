`ifndef FEW_COIN_TEST
`define FEW_COIN_TEST
class few_coin_test extends user_base_test #(
	few_coin_seq
);
	`uvm_component_utils(few_coin_test)
	
	function new(string name = "few_coin_test", uvm_component parent);
		super.new(name, parent);
	endfunction
	
	
endclass
`endif