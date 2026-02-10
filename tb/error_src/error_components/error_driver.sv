`ifndef ERROR_DRIVER
`define ERROR_DRIVER
class error_driver extends base_driver #(
    .INTERFACE_TYPE  (virtual error_interface),
    .TRANSACTION_TYPE(error_transaction      )
);

    `uvm_component_utils(error_driver)

    function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new

    task reset();
		vif.tamper_detect  <= 0;
		vif.jam_detect     <= 0;
		vif.power_loss     <= 0;
	endtask: reset

    task drive_transaction (error_transaction tr);
        
        #(tr.time_delay);
        `uvm_info(get_type_name(), tr.convert2string(), UVM_LOW)
        vif.tamper_detect  <= tr.tamper_detect;
		vif.jam_detect     <= tr.jam_detect;
		vif.power_loss     <= tr.power_loss;
        repeat (3) wait_for_active_clock();
    endtask

endclass
`endif