`ifndef TEST_INVALID_COIN_DENOMINATION
`define TEST_INVALID_COIN_DENOMINATION

class test_invalid_coin_denomination extends user_base_test #(
    invalid_coin_denomination_seq
);

	`uvm_component_utils(test_invalid_coin_denomination)

	function new(string name = "test_invalid_coin_denomination", uvm_component parent = null);
		super.new(name, parent);
    endfunction
    
endclass
`endif