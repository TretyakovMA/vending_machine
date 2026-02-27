`ifndef CONFIRM_TIMEOUT
`define CONFIRM_TIMEOUT

class confirm_timeout extends user_driver_cb;
  `uvm_object_utils(confirm_timeout)

  function new(string name = "confirm_timeout");
    super.new(name);
  endfunction

    task delay_before_confirm(virtual user_interface vif);
        repeat(150) @(posedge vif.clk);
    endtask: delay_before_confirm
endclass
`endif