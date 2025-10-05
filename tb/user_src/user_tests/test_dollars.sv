`ifndef TEST_DOLLARS
`define TEST_DOLLARS
class test_dollars extends user_base_test;
	`uvm_component_utils(test_dollars)
	
	function new(string name = "test_dollars", uvm_component parent);
		super.new(name, parent);
	endfunction
	
	function uvm_sequence #(user_transaction) get_sequence();
        return test_dollars_seq::type_id::create("seq");
    endfunction
endclass
`endif