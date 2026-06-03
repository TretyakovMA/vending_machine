`ifndef USER_AGENT
`define USER_AGENT
class user_agent extends base_agent #(
	.INTERFACE_TYPE   (virtual user_interface), 
	.TRANSACTION_TYPE (user_transaction      ), 
	.DRIVER_TYPE      (user_driver           ), 
	.MONITOR_TYPE     (user_monitor          )
);

	`uvm_component_utils(user_agent);
	
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

	function string set_sequencer_name();
        return "user_sequencer";  
    endfunction: set_sequencer_name

endclass
`endif
