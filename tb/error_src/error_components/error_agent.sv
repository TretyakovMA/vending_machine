`ifndef ERROR_AGENT
`define ERROR_AGENT

class error_agent extends base_agent #(
	.INTERFACE_TYPE   (virtual error_interface), 
	.TRANSACTION_TYPE (error_transaction      ), 
	.DRIVER_TYPE      (error_driver           ),
	.MONITOR_TYPE     (error_monitor          )
);

    `uvm_component_utils(error_agent)

    function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

endclass
`endif