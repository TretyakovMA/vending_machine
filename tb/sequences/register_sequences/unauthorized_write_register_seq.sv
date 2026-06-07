`ifndef UNAUTORIZED_WRITE_REGISTER_SEQ
`define UNAUTORIZED_WRITE_REGISTER_SEQ

class unauthorized_write_register_seq extends register_base_seq;

    `uvm_object_utils(unauthorized_write_register_seq)

    function new(string name = "unauthorized_write_register_seq");
        super.new(name);
    endfunction



    function bit is_need_admin_mode();
        return 0;
    endfunction: is_need_admin_mode

    task body();
        super.body();

        registers.shuffle();
        
        foreach (registers[i]) begin
            write_random_value(registers[i]);
        end

        reg_block_h.print();

    endtask: body
endclass
`endif