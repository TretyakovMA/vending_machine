`ifndef WRITE_REGISTERS_WITH_EMERGENCY_SEQ
`define WRITE_REGISTERS_WITH_EMERGENCY_SEQ

class write_registers_with_emergency_seq extends register_base_seq;
    `uvm_object_utils(write_registers_with_emergency_seq)

    function new(string name = "write_registers_with_emergency_seq");
		super.new(name);
	endfunction



    task body();
        super.body();

        foreach(registers[i]) begin
            write_random_value(registers[i]);
        end
            
        reg_block_h.print();
        	
    endtask: body
endclass
`endif