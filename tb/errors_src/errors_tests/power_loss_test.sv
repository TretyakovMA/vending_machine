`ifndef POWER_LOSS_TEST
`define POWER_LOSS_TEST
class power_loss_test extends errors_base_test #(
	power_loss_vseq
);
	`uvm_component_utils(power_loss_test)
	
	function new(string name = "power_loss_test", uvm_component parent);
		super.new(name, parent);
	endfunction
	
endclass
`endif