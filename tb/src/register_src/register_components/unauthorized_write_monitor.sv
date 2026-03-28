`ifndef UNAUTHORIZED_WRITE_MONITOR
`define UNAUTHORIZED_WRITE_MONITOR

class unauthorized_write_monitor extends register_monitor;

    `uvm_component_utils(unauthorized_write_monitor)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new
    
    task _wait_for_sampling_event_();
        @(posedge vif.clk);
    endtask: _wait_for_sampling_event_

endclass
`endif