`ifndef RESET_AGENT
`define RESET_AGENT

class reset_agent extends base_agent #(
    .INTERFACE_TYPE   (virtual reset_interface),
    .TRANSACTION_TYPE (reset_transaction      ),
    .DRIVER_TYPE      (reset_driver           ),
    .MONITOR_TYPE     (reset_monitor          )
);

    `uvm_component_utils(reset_agent)

    function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction
	
endclass
`endif