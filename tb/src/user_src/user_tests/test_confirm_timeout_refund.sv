`ifndef TEST_CONFIRM_TIMEOUT_REFUND
`define TEST_CONFIRM_TIMEOUT_REFUND

class test_confirm_timeout_refund extends user_base_test #(
	full_client_session_with_no_errors_seq #(1)
);

	`uvm_component_utils(test_confirm_timeout_refund)

	function new(string name = "test_confirm_timeout_refund", uvm_component parent);
		super.new(name, parent);
	endfunction: new

    function void create_callbacks(); 
        user_driver     driver_h;
        confirm_timeout cb;

        if (!uvm_config_db #(user_driver)::get(this, "", "user_driver", driver_h))
            `uvm_fatal(get_type_name(), "Failed to get user driver from config_db")
        
        
        cb = confirm_timeout::type_id::create("cb");

        uvm_callbacks #(user_driver, user_driver_cb)::add(driver_h, cb);

	endfunction: create_callbacks

endclass
`endif