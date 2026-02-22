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



    task reset();
        vif.rst_n <= 0;
    endtask: reset

    task drive_transaction(reset_transaction tr);
        
        #(tr.time_delay);
        vif.rst_n <= 0;
        #(tr.duration);
        vif.rst_n <= 1;
        
    endtask: drive_transaction

endclass
`endif