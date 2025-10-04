`ifndef VOID_MONITOR
`define VOID_MONITOR


class void_monitor #(
    type INTERFACE_TYPE,
	type TRANSACTION_TYPE
) extends uvm_monitor;
    `uvm_component_param_utils(void_monitor #(INTERFACE_TYPE, TRANSACTION_TYPE))

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    uvm_analysis_port #(TRANSACTION_TYPE) ap;
    INTERFACE_TYPE   vif;
endclass

`endif