`ifndef CHECK_AFTER_RESET_TEST   
`define CHECK_AFTER_RESET_TEST
class check_after_reset_test extends register_base_test #(
    check_after_reset_seq
);
    `uvm_component_utils(check_after_reset_test)
	
	function new(string name = "check_after_reset_test", uvm_component parent);
		super.new(name, parent);
	endfunction
	
	
endclass
`endif