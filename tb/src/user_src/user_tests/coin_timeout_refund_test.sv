`ifndef COIN_TIMEOUT_REFUND_TEST
`define COIN_TIMEOUT_REFUND_TEST

class coin_timeout_refund_test extends user_base_test #(
	client_session_without_errors_seq #(1)
);

	`uvm_component_utils(coin_timeout_refund_test)


	function new(string name = "coin_timeout_refund_test", uvm_component parent);
		super.new(name, parent);
	endfunction

    function void create_callbacks(); 
        user_driver  driver_h;
        coin_timeout cb;

        if (!uvm_config_db #(user_driver)::get(this, "", "user_driver", driver_h))
            `uvm_fatal(get_type_name(), "Failed to get user driver from config_db")
        
        
        cb = coin_timeout::type_id::create("cb");

        uvm_callbacks #(user_driver, user_driver_cb)::add(driver_h, cb);

	endfunction: create_callbacks

endclass
`endif