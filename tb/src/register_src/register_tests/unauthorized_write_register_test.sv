`ifndef UNAUTORIZED_WRITE_REGISTER_TEST
`define UNAUTORIZED_WRITE_REGISTER_TEST
class unauthorized_write_register_test extends register_base_test #(
    unauthorized_write_register_seq
);
    `uvm_component_utils(unauthorized_write_register_test)

    function new(string name = "unauthorized_write_register_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void create_callbacks(); 
        register_monitor  monitor_h;
        unauthorized_write_cb cb;

        if (!uvm_config_db #(register_monitor)::get(this, "", "register_monitor", monitor_h))
            `uvm_fatal(get_type_name(), "Failed to get user monitor from config_db")
        
        
        cb = unauthorized_write_cb::type_id::create("cb");

        uvm_callbacks #(register_monitor, register_monitor_cb)::add(monitor_h, cb);

	endfunction: create_callbacks

endclass
`endif