`ifndef SIMPLE_TEST
`define SIMPLE_TEST
class simple_test extends user_base_test;
	`uvm_component_utils(simple_test)
	
	function new(string name = "simple_test", uvm_component parent);
		super.new(name, parent);
	endfunction
	
	function uvm_sequence #(user_transaction) get_sequence();
        return simple_test_seq::type_id::create("seq");
    endfunction
endclass
`endif