`ifndef EMERGENCY_DRIVER
`define EMERGENCY_DRIVER
class emergency_driver extends vm_base_driver #(
    .INTERFACE_TYPE   (virtual emergency_interface), 
	.TRANSACTION_TYPE (emergency_transaction      ) 
);

    `uvm_component_utils(emergency_driver)

    function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new



    `uvm_register_cb(emergency_driver, emergency_driver_cb)


    task reset();
		vif.tamper_detect  <= 0;
		vif.jam_detect     <= 0;
		vif.power_loss     <= 0;
	endtask: reset

    task drive_transaction (emergency_transaction tr);
        #(tr.time_delay);

        vif.tamper_detect  <= tr.tamper_detect;
		vif.jam_detect     <= tr.jam_detect;
		vif.power_loss     <= tr.power_loss;
        `uvm_info(get_type_name(), {"Send transaction: ", tr.convert2string()}, UVM_LOW)

        `uvm_do_callbacks(emergency_driver, emergency_driver_cb, post_drive(vif))
    endtask: drive_transaction

endclass
`endif