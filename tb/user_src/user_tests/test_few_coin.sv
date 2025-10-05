`ifndef TEST_FEW_COIN
`define TEST_FEW_COIN
class test_few_coin extends base_test;
	`uvm_component_utils(test_few_coin)
	
	function new(string name = "test_few_coin", uvm_component parent);
		super.new(name, parent);
	endfunction
	
	function uvm_sequence #(user_transaction) get_sequence();
        return test_few_coin_seq::type_id::create("seq");
    endfunction
	
endclass
`endif