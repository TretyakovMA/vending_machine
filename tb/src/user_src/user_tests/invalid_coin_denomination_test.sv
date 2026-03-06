`ifndef INVALID_COIN_DENOMINATION_TEST
`define INVALID_COIN_DENOMINATION_TEST

class invalid_coin_denomination_test extends user_base_test #(
    invalid_coin_denomination_seq
);

	`uvm_component_utils(invalid_coin_denomination_test)

	function new(string name = "invalid_coin_denomination_test", uvm_component parent = null);
		super.new(name, parent);
    endfunction
    
endclass
`endif