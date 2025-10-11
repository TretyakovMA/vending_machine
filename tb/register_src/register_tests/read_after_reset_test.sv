`ifndef READ_AFTER_RESET_TEST
`define READ_AFTER_RESET_TEST
class read_after_reset_test extends register_base_test #(
	read_after_reset_test_seq
);
	`uvm_component_utils(read_after_reset_test)
	
	function new(string name = "read_after_reset_test", uvm_component parent);
		super.new(name, parent);
	endfunction
	
	
endclass
`endif