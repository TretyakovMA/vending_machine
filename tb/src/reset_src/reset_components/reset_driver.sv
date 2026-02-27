`ifndef RESET_DRIVER
`define RESET_DRIVER
class reset_driver extends vm_base_driver #(
    .INTERFACE_TYPE   (virtual reset_interface),
    .TRANSACTION_TYPE (reset_transaction      )
);

    `uvm_component_utils(reset_driver)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new



    task _reset_();
        vif.rst_n <= 0;
    endtask: _reset_

    task _drive_transaction_(reset_transaction tr);
        
        #(tr.time_delay);
        vif.rst_n <= 0;
        #(tr.duration);
        vif.rst_n <= 1;
        
    endtask: _drive_transaction_

endclass
`endif