`ifndef TEST_EUROS
`define TEST_EUROS
class test_euros extends user_base_test;
	`uvm_component_utils(test_euros)
	
	function new(string name = "test_euros", uvm_component parent);
		super.new(name, parent);
	endfunction
	
	function uvm_sequence #(user_transaction) get_sequence();
        return test_euros_seq::type_id::create("seq");
    endfunction
endclass
`endif