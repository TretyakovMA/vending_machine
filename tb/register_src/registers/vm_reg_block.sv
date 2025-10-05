`ifndef VM_REG_BLOCK
`define VM_REG_BLOCK
class vm_reg_block extends uvm_reg_block;
	`uvm_object_utils(vm_reg_block)
	
	rand vend_cfg_reg    vend_cfg;
	vend_clients_reg     vend_clients;
	rand vend_paswd_reg  vend_paswd;
	rand vend_item_reg   vend_item[10];
  
	uvm_reg_map          reg_map;
	
	function new(string name = "vm_reg_block");
		super.new(.name(name), .has_coverage(UVM_NO_COVERAGE));
	endfunction
	
	virtual function void build();
		reg_map = create_map("reg_map", 'h0, 4, UVM_LITTLE_ENDIAN);
    
		vend_cfg = vend_cfg_reg::type_id::create("vend_cfg");
		vend_cfg.configure(this);
		vend_cfg.build();
		reg_map.add_reg(vend_cfg, 'h00, "RW");
    
		vend_clients = vend_clients_reg::type_id::create("vend_clients");
		vend_clients.configure(this);
		vend_clients.build();
		reg_map.add_reg(vend_clients, 'h04, "RW");
		
		vend_paswd = vend_paswd_reg::type_id::create("vend_paswd");
		vend_paswd.configure(this);
		vend_paswd.build();
		reg_map.add_reg(vend_paswd, 'h08, "RW");
    
		foreach (vend_item[i]) begin
			vend_item[i] = vend_item_reg::type_id::create($sformatf("vend_item%0d", i));
			vend_item[i].configure(this);
			vend_item[i].build();
			vend_item[i].item_price.set_reset((i+1) * 10);
			reg_map.add_reg(vend_item[i], 'h0C + (i*4), "RW");
		end
		
		lock_model();
	endfunction
endclass
`endif