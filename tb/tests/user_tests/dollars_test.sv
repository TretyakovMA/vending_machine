`ifndef DOLLARS_TEST
`define DOLLARS_TEST
class dollars_test extends user_base_test #(
	dollars_seq
);
	`uvm_component_utils(dollars_test)
	
	function new(string name = "dollars_test", uvm_component parent);
		super.new(name, parent);
	endfunction
	
endclass
`endif