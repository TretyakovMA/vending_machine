`ifndef INSUFFICIENT_FUNDS_TEST
`define INSUFFICIENT_FUNDS_TEST

class insufficient_funds_test extends user_base_test#(
    insufficient_funds_seq
);

	`uvm_component_utils(insufficient_funds_test)

	function new(string name = "insufficient_funds_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction

endclass
`endif