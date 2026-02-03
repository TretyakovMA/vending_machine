`ifndef REGISTER_BASE_SEQ
`define REGISTER_BASE_SEQ
class register_base_seq extends uvm_reg_sequence;
    `uvm_object_utils(register_base_seq)

    vm_reg_block               reg_block_h;
	protected uvm_status_e     status;
	protected uvm_reg_data_t   value;
    protected bit[31:0]        mirrored_value;
	protected uvm_reg          registers[$];
    local     bit              has_registers = 0;
    
    function new(string name = "base_reg_seq");
        super.new(name);
    endfunction: new



    function void get_registers();
        if(!uvm_config_db #(vm_reg_block)::get(null, "", "reg_block_h", reg_block_h))
			`uvm_fatal(get_type_name(), "Failed to get reg_block_h")
        
        reg_block_h.get_registers(registers);
        has_registers = 1;
    endfunction: get_registers

    task check_registers();
		foreach(registers[i])begin
			mirrored_value = registers[i].get_mirrored_value();
            mirror_reg(registers[i], status, UVM_CHECK, UVM_BACKDOOR);
			if(value != mirrored_value) begin
				void '(registers[i].predict(mirrored_value));
			end
			else begin
				`uvm_info(get_type_name(), $sformatf("Register %s match: value 0x%0h", registers[i].get_name(), value), UVM_HIGH)
			end
		end
	endtask: check_registers

    task body();
        if (!has_registers)
            get_registers();
        
    endtask: body
endclass
`endif