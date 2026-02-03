`ifndef CHECK_AFTER_WRITE_TEST
`define CHECK_AFTER_WRITE_TEST
class check_after_write_test extends register_base_test #(
	check_after_write_seq
);
	`uvm_component_utils(check_after_write_test)
	
	function new(string name = "check_after_write_test", uvm_component parent);
		super.new(name, parent);
	endfunction
	
	
endclass
`endif