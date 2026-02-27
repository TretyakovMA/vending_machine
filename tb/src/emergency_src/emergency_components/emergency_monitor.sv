`ifndef EMERGENCY_MONITOR
`define EMERGENCY_MONITOR
class emergency_monitor extends vm_base_monitor #(
	.INTERFACE_TYPE   (virtual emergency_interface), 
	.TRANSACTION_TYPE (emergency_transaction      ) 
);

    `uvm_component_utils(emergency_monitor)
	
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new



    task _wait_for_sampling_event_(); 
        fork
            @(edge vif.tamper_detect);
            @(edge vif.jam_detect);
            @(edge vif.power_loss);
        join_any
        @(posedge vif.clk);
    endtask: _wait_for_sampling_event_
    
    task _collect_transaction_data_ (emergency_transaction tr);
        tr.tamper_detect = vif.tamper_detect;
        tr.jam_detect    = vif.jam_detect;
        tr.power_loss    = vif.power_loss;
        @(posedge vif.clk);
        tr.alarm         = vif.alarm;
    endtask: _collect_transaction_data_
endclass
`endif
	