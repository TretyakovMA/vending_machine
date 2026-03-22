`ifndef UNAUTHORIZED_WRITE_CB
`define UNAUTHORIZED_WRITE_CB
class unauthorized_write_cb extends register_monitor_cb;

    `uvm_object_utils(unauthorized_write_cb)

    function new(string name = "unauthorized_write_cb");
		super.new(name);
	endfunction: new

    virtual task need_deadbeef_sensitive(ref bit need);
        need = 1;
    endtask: need_deadbeef_sensitive
endclass
`endif