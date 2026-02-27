`ifndef DELAY_AFTER_ALARM_TEST_CB
`define DELAY_AFTER_ALARM_TEST_CB
class delay_after_alarm_test_cb extends emergency_driver_cb;

    `uvm_object_utils(delay_after_alarm_test_cb)

    function new(string name = "delay_after_alarm_test_cb");
		super.new(name);
	endfunction: new

    virtual task post_drive(virtual emergency_interface vif);
        repeat (2) @(posedge vif.clk);
        `uvm_info(get_type_name(), "Post main", UVM_HIGH)
    endtask: post_drive

endclass
`endif