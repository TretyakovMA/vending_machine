`ifndef REGISTER_TEST
`define REGISTER_TEST
class register_test extends register_base_test #(
	register_test_seq
);
	`uvm_component_utils(register_test)
	
	function new(string name = "register_test", uvm_component parent);
		super.new(name, parent);
	endfunction
	
	
endclass
`endif