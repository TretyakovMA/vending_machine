`ifndef REGISTER_ENV
`define REGISTER_ENV
class register_env extends uvm_env;
	`uvm_component_utils(register_env);
	
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction
	
	
	
	register_adapter       adapter_h;
	register_predictor     predictor_h;
	vm_reg_block           reg_block_h;
	
	
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		predictor_h = register_predictor::type_id::create("predictor_h", this);
		adapter_h   = register_adapter::type_id::create("adapter_h", this);
		reg_block_h = vm_reg_block::type_id::create("reg_block_h", this);
		reg_block_h.build();
		uvm_config_db #(vm_reg_block)::set(null, "*", "reg_block", reg_block_h);
	endfunction
	
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		
		predictor_h.map     = reg_block_h.reg_map;
		predictor_h.adapter = adapter_h;
		
	endfunction 
endclass
`endif