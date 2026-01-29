`ifndef BASE_TRANSACTION
`define BASE_TRANSACTION
virtual class base_transaction extends uvm_sequence_item;

    `uvm_object_utils(base_transaction)

    function new(string name = "base_transaction");
        super.new(name);
    endfunction: new

    bit has_reset = 0;

endclass : base_transaction
`endif