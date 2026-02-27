`ifndef COIN_TIMEOUT
`define COIN_TIMEOUT

class coin_timeout extends user_driver_cb;

	`uvm_object_utils(coin_timeout)

	function new(string name = "coin_timeout");
		super.new(name);
	endfunction: new

    task delay_in_coin_deposit(virtual user_interface vif);
        if($urandom_range(1))
            @(posedge vif.clk);
    endtask: delay_in_coin_deposit

endclass
`endif