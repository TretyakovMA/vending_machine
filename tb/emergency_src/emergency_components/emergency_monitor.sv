`ifndef EMERGENCY_MONITOR
`define EMERGENCY_MONITOR
class emergency_monitor extends base_monitor #(
	.INTERFACE_TYPE   (virtual emergency_interface), 
	.TRANSACTION_TYPE (emergency_transaction      ) 
);

    `uvm_component_utils(emergency_monitor)
	
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new

    

    function bit should_start_monitoring();
        return (vif.tamper_detect || vif.jam_detect || vif.power_loss) && (vif.rst_n == 1);
    endfunction: should_start_monitoring
    
    task collect_transaction_data (emergency_transaction tr);
        tr.tamper_detect = vif.tamper_detect;
        tr.jam_detect    = vif.jam_detect;
        tr.power_loss    = vif.power_loss;
        @(posedge vif.clk);
        tr.alarm         = vif.alarm;
    endtask: collect_transaction_data
endclass
`endif
	