`ifndef BASE_REG_SEQ
`define BASE_REG_SEQ
class base_reg_seq extends uvm_reg_sequence;
    `uvm_object_utils(base_reg_seq)

    vm_reg_block     reg_block_h;
	uvm_status_e     status;
	uvm_reg_data_t   value;
	uvm_reg          registers[$];
    
    function new(string name = "base_reg_seq");
        super.new(name);
    endfunction: new

    task body();
        model = reg_block_h;
        reg_block_h.get_registers(registers);
    endtask: body
endclass
`endif