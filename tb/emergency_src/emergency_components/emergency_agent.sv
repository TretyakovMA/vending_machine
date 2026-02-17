`ifndef EMERGENCY_AGENT
`define EMERGENCY_AGENT

class emergency_agent extends base_agent #(
	.INTERFACE_TYPE   (virtual emergency_interface), 
	.TRANSACTION_TYPE (emergency_transaction      ), 
	.DRIVER_TYPE      (emergency_driver           ),
	.MONITOR_TYPE     (emergency_monitor          )
);

    `uvm_component_utils(emergency_agent)

    function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

endclass
`endif