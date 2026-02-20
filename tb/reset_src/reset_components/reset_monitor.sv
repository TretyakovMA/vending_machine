`ifndef RESET_MONITOR
`define RESET_MONITOR
class reset_monitor extends base_monitor #(
    .INTERFACE_TYPE   (virtual reset_interface),
    .TRANSACTION_TYPE (reset_transaction      )
);

    `uvm_component_utils(reset_monitor)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    

    task collect_transaction_data(reset_transaction tr);
        tr.rst_n = vif.rst_n;
    endtask: collect_transaction_data

    function bit should_start_monitoring ();
        return 1;
    endfunction: should_start_monitoring

    task wait_for_sampling_event(); 
		@(negedge vif.rst_n);
	endtask: wait_for_sampling_event

endclass
`endif