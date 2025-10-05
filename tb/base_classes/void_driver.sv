`ifndef VOID_DRIVER
`define VOID_DRIVER


class void_driver #(
    type INTERFACE_TYPE,
	type TRANSACTION_TYPE
) extends uvm_driver #(TRANSACTION_TYPE);
    `uvm_component_param_utils(void_driver #(INTERFACE_TYPE, TRANSACTION_TYPE))

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    INTERFACE_TYPE   vif;
endclass

`endif