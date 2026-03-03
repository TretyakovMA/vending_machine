`ifndef ADMIN_MONITOR
`define ADMIN_MONITOR
class admin_monitor extends vm_base_monitor #(
	.INTERFACE_TYPE   (virtual admin_interface), 
	.TRANSACTION_TYPE (admin_transaction      )
);

	`uvm_component_utils(admin_monitor)
	
	function new(string name, uvm_component parent);
		super.new(name, parent);
    endfunction: new

    task _wait_for_sampling_event_(); 
        @(edge vif.admin_mode);
    endtask: _wait_for_sampling_event_

    task _collect_transaction_data_ (admin_transaction tr);
        tr.admin_mode     = vif.admin_mode;
        tr.admin_password = vif.admin_password;
    endtask: _collect_transaction_data_

endclass
`endif