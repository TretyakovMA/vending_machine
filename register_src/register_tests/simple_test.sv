`ifndef REGISTER_SIMPLE_TEST
`define REGISTER_SIMPLE_TEST
class register_simple_test extends base_test;
	`uvm_component_utils(register_simple_test)
	
	function new(string name = "register_simple_test", uvm_component parent);
		super.new(name, parent);
	endfunction
	
	function uvm_sequence #(admin_transaction) get_sequence();
        return register_simple_test_seq::type_id::create("r_seq");
    endfunction
endclass
`endif