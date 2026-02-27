`ifndef USER_DRIVER_CB
`define USER_DRIVER_CB
class user_driver_cb extends uvm_callback;

	`uvm_object_utils(user_driver_cb)

	function new(string name = "user_driver_cb");
		super.new(name);
	endfunction

    virtual task delay_in_coin_deposit(virtual user_interface vif);
    endtask: delay_in_coin_deposit

    virtual task delay_bafore_confirm(virtual user_interface vif);
    endtask: delay_bafore_confirm

endclass
`endif