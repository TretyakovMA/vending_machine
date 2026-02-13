`ifndef VOID_CLASSES
`define VOID_CLASSES

// Здесь собраны классы, которые нужны для использования
// в качестве значений параметров по умолчанию 
// (например для base_agent, иначе придется сделать base_driver и base_monitor
// не виртуальными, а я этого не хочу)

class void_driver #(
    type INTERFACE_TYPE,
	type TRANSACTION_TYPE
) extends uvm_driver#(TRANSACTION_TYPE);
    `uvm_component_param_utils(void_driver #(INTERFACE_TYPE, TRANSACTION_TYPE))

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    INTERFACE_TYPE    vif;
endclass



class void_monitor #(
    type INTERFACE_TYPE,
	type TRANSACTION_TYPE
) extends uvm_monitor;
    `uvm_component_param_utils(void_monitor #(INTERFACE_TYPE, TRANSACTION_TYPE))

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    uvm_analysis_port #(TRANSACTION_TYPE) ap;
    INTERFACE_TYPE    vif;
endclass

class void_sequence extends uvm_sequence #(uvm_sequence_item);
    `uvm_object_utils(void_sequence)

    function new(string name = "void_sequence");
        super.new(name);
    endfunction
endclass
`endif