`ifndef REGISTER_ADAPTER
`define REGISTER_ADAPTER

class register_adapter extends uvm_reg_adapter;
	`uvm_object_utils(register_adapter)
  
	function new(string name = "register_adapter");
		super.new(name);
		supports_byte_enable = 0;
		provides_responses = 0;
	endfunction
	
	virtual function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
		register_transaction tr;
		tr = register_transaction::type_id::create("tr");
		
		tr.regs_addr = rw.addr;
		tr.regs_we = (rw.kind == UVM_WRITE) ? 1 : 0;
		
		if (rw.kind == UVM_WRITE) begin
			tr.regs_data_in = rw.data;
		end
		else begin
			tr.regs_data_out = rw.data;
		end
		`uvm_info ("adapter", {"reg2bus: ", tr.convert2string()}, UVM_HIGH) 
		return tr;
	endfunction
	
	
	virtual function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
		register_transaction tr;
		
		if (!$cast(tr, bus_item)) begin
			`uvm_fatal("REGISTER_ADAPTER", "Invalid transaction type")
		end
		
		rw.kind = (tr.regs_we == 1) ? UVM_WRITE : UVM_READ;
		rw.addr = tr.regs_addr;
		if (tr.regs_we == 1) begin
			rw.data = tr.regs_data_in;
		end 
		else begin
			rw.data = tr.regs_data_out;
		end
		`uvm_info ("adapter", {"Get transaction: ", tr.convert2string()}, UVM_FULL) 
		`uvm_info ("adapter", $sformatf("bus2reg : addr=0x%0h data=0x%0h kind=%s status=%s", rw.addr, rw.data, rw.kind.name(), rw.status.name()), UVM_HIGH)
		rw.status = UVM_IS_OK;  
	endfunction
	
endclass
`endif