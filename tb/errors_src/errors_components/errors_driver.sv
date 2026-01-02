`ifndef ERRORS_DRIVER
`define ERRORS_DRIVER
class errors_driver extends base_driver #(
    .INTERFACE_TYPE  (virtual errors_interface),
    .TRANSACTION_TYPE(errors_transaction)
);

    `uvm_component_utils(errors_driver)

    function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new

    task reset();
		vif.tamper_detect  <= 0;
		vif.jam_detect     <= 0;
		vif.power_loss     <= 0;
	endtask: reset

    task drive_transaction (errors_transaction tr);
        `uvm_info(get_type_name(), "Start work", UVM_LOW)
        #(tr.time_delay);
        `uvm_info(get_type_name(), tr.convert2string(), UVM_LOW)
        vif.tamper_detect  <= tr.tamper_detect;
		vif.jam_detect     <= tr.jam_detect;
		vif.power_loss     <= tr.power_loss;
        #500;
    endtask

endclass
`endif