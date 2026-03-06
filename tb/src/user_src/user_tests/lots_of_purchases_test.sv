`ifndef LOTS_OF_PURCHASES_TEST
`define LOTS_OF_PURCHASES_TEST
class lots_of_purchases_test extends user_base_test #(
	lots_of_purchases_seq
);
	`uvm_component_utils(lots_of_purchases_test)
	
	function new(string name = "lots_of_purchases_test", uvm_component parent);
		super.new(name, parent);
	endfunction
	
endclass
`endif