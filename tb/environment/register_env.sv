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
	vm_reg_access_cb       reg_cb_h;
	
	
	
	function void build_phase(uvm_phase phase);
		uvm_reg_field fields[$];

		super.build_phase(phase);
		predictor_h = register_predictor::type_id::create("predictor_h", this);
		adapter_h   = register_adapter::type_id::create("adapter_h", this);
		reg_block_h = vm_reg_block::type_id::create("reg_block_h", this);
		reg_block_h.build();
		reg_cb_h    = vm_reg_access_cb::type_id::create("reg_cb_h");

		reg_block_h.get_fields(fields);
		foreach (fields[i]) begin
			uvm_reg_field_cb::add(fields[i], reg_cb_h);
		end
		
		uvm_config_db #(vm_reg_access_cb)::set(null, "*", "reg_cb", reg_cb_h);
		uvm_config_db #(vm_reg_block)::set(null, "*", "reg_block", reg_block_h);
	endfunction
	
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		
		predictor_h.map     = reg_block_h.reg_map;
		predictor_h.adapter = adapter_h;
		
	endfunction 
endclass
`endif