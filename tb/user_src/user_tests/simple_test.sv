`ifndef SIMPLE_TEST
`define SIMPLE_TEST
class simple_test extends user_base_test #(
	simple_test_seq
);
	`uvm_component_utils(simple_test)
	
	function new(string name = "simple_test", uvm_component parent);
		super.new(name, parent);
	endfunction
	
	
endclass
`endif