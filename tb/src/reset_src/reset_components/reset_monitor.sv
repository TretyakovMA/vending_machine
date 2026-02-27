`ifndef RESET_MONITOR
`define RESET_MONITOR
class reset_monitor extends vm_base_monitor #(
    .INTERFACE_TYPE   (virtual reset_interface),
    .TRANSACTION_TYPE (reset_transaction      )
);

    `uvm_component_utils(reset_monitor)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    

    task _wait_for_sampling_event_(); 
		@(negedge vif.rst_n);
	endtask: _wait_for_sampling_event_

    task _collect_transaction_data_(reset_transaction tr);
        tr.rst_n = vif.rst_n;
    endtask: _collect_transaction_data_

endclass
`endif