`ifndef TEST_ONE_COIN
`define TEST_ONE_COIN
class test_one_coin extends user_base_test;
	`uvm_component_utils(test_one_coin)
	
	function new(string name = "test_one_coin", uvm_component parent);
		super.new(name, parent);
	endfunction
	
	function uvm_sequence #(user_transaction) get_sequence();
        return test_one_coin_seq::type_id::create("seq");
    endfunction
endclass
`endif