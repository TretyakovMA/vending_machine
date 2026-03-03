`ifndef WRITE_REGISTERS_WITH_INVALID_PASSWORD_SEQ
`define WRITE_REGISTERS_WITH_INVALID_PASSWORD_SEQ

class write_registers_with_invalid_password_seq extends register_base_seq;

    `uvm_object_utils(write_registers_with_invalid_password_seq)

    function new(string name = "write_registers_with_invalid_password_seq");
        super.new(name);
    endfunction

    function bit is_correct_admin_password();
        return 0;
    endfunction: is_correct_admin_password

    task body();
        super.body();

        //registers.shuffle();
        
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