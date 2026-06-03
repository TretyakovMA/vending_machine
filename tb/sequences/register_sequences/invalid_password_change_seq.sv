`ifndef INVALID_PASSWORD_CHANGE_SEQ
`define INVALID_PASSWORD_CHANGE_SEQ

class invalid_password_change_seq extends register_base_seq;
    `uvm_object_utils(invalid_password_change_seq)

    function new(string name = "invalid_password_change_seq");
		super.new(name);
	endfunction

    task body();
        super.body();
        peek_reg(reg_block_h.vend_paswd, status, old_value);
        
        value[31:8] = 0;
        value[7:0]  = $urandom_range(255);
        write_reg(reg_block_h.vend_paswd, status, value);

        reg_block_h.print();

        peek_reg(reg_block_h.vend_paswd, status, value);

        if(value != old_value)
            `uvm_error(get_type_name(), "Password was changed after incorrect password")
        
        reg_block_h.print();
    endtask: body

endclass
`endif