`ifndef TEST_LOTS_OF_PURCHASES
`define TEST_LOTS_OF_PURCHASES
class test_lots_of_purchases extends base_test;
	`uvm_component_utils(test_lots_of_purchases)
	
	function new(string name = "test_lots_of_purchases", uvm_component parent);
		super.new(name, parent);
	endfunction
	
	function uvm_sequence #(user_transaction) get_sequence();
        return test_lots_of_purchases_seq::type_id::create("seq");
    endfunction
endclass
`endif