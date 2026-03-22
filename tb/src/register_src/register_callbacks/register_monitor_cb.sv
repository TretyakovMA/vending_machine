`ifndef REGISTER_MONITOR_CB
`define REGISTER_MONITOR_CB
class register_monitor_cb extends uvm_callback;

	`uvm_object_utils(register_monitor_cb)

	function new(string name = "register_monitor_cb");
		super.new(name);
    endfunction: new

    virtual task need_deadbeef_sensitive(ref bit need);
    endtask: need_deadbeef_sensitive

endclass
`endif