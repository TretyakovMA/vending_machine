`ifndef EMERGENCY_DRIVER_CB
`define EMERGENCY_DRIVER_CB

class emergency_driver_cb extends uvm_callback;

    `uvm_object_utils(emergency_driver_cb)

    function new(string name = "emergency_driver_cb");
        super.new(name);
    endfunction

    virtual task post_drive(virtual emergency_interface vif);

    endtask: post_drive
endclass
`endif