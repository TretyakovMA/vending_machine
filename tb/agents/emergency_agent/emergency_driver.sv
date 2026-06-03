`ifndef EMERGENCY_DRIVER
`define EMERGENCY_DRIVER
class emergency_driver extends base_driver #(
    .INTERFACE_TYPE   (virtual emergency_interface), 
	.TRANSACTION_TYPE (emergency_transaction      ) 
);

    `uvm_component_utils(emergency_driver)

    function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new



    task _wait_for_reset_deassert_();
		@(posedge vif.clk iff vif.rst_n == 1);
	endtask: _wait_for_reset_deassert_

	task _wait_for_reset_assert_();
		@(negedge vif.rst_n);
	endtask: _wait_for_reset_assert_



    task _reset_();
		vif.tamper_detect  <= 0;
		vif.jam_detect     <= 0;
		vif.power_loss     <= 0;
	endtask: _reset_

    task _drive_transaction_ (emergency_transaction tr);
        #(tr.time_delay);

        vif.tamper_detect  <= tr.tamper_detect;
		vif.jam_detect     <= tr.jam_detect;
		vif.power_loss     <= tr.power_loss;
        `uvm_info(get_type_name(), {"Send transaction: ", tr.convert2string()}, UVM_MEDIUM)
    endtask: _drive_transaction_

endclass
`endif