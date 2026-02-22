`ifndef CHECK_READ_TEST
`define CHECK_READ_TEST
class check_read_test extends register_base_test #(
	check_read_seq
);
	`uvm_component_utils(check_read_test)
	
	function new(string name = "check_read_test", uvm_component parent);
		super.new(name, parent);
	endfunction
	
endclass
`endif