`ifndef CHECK_AFTER_RESET_SEQ
`define CHECK_AFTER_RESET_SEQ
class check_after_reset_seq extends register_base_seq;
    `uvm_object_utils(check_after_reset_seq)

    function new(string name = "check_after_reset_seq");
        super.new(name);
    endfunction: new

    task body();
        super.body();

        check_registers();

        reg_block_h.print();
        
    endtask: body
endclass
`endif