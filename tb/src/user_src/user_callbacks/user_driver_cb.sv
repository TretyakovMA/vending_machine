`ifndef USER_DRIVER_CB
`define USER_DRIVER_CB
class user_driver_cb extends uvm_callback;

	`uvm_object_utils(user_driver_cb)

	function new(string name = "user_driver_cb");
		super.new(name);
    endfunction: new

    virtual task delay_in_coin_deposit(virtual user_interface vif);
    endtask: delay_in_coin_deposit

    virtual task delay_before_confirm(virtual user_interface vif);
    endtask: delay_before_confirm

    virtual task delay_before_next_client(virtual user_interface vif);
    endtask: delay_before_next_client

endclass
`endif