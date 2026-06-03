`ifndef EUROS_TEST
`define EUROS_TEST
class euros_test extends user_base_test #(
	euros_seq
);
	`uvm_component_utils(euros_test)
	
	function new(string name = "euros_test", uvm_component parent);
		super.new(name, parent);
	endfunction
	
endclass
`endif