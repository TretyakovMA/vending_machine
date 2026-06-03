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
            peek_reg(registers[i], status, old_value);
            write_random_value(registers[i]);
            void '(registers[i].predict(old_value));
        end

        #1;
        check_registers();
        reg_block_h.print();

        foreach (registers[i]) begin
            read_reg(registers[i], status, value);
        end

    endtask: body
endclass
`endif