`ifndef ERRORS_AGENT
`define ERRORS_AGENT

class errors_agent extends base_agent #(
	.INTERFACE_TYPE   (virtual errors_interface), 
	.TRANSACTION_TYPE (errors_transaction), 
	.DRIVER_TYPE      (errors_driver)
);

    `uvm_component_utils(errors_agent)

    function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

endclass
`endif