`ifndef VEND_PASWD_REG
`define VEND_PASWD_REG
class vend_paswd_reg extends uvm_reg;
	`uvm_object_utils(vend_paswd_reg)
	
	rand uvm_reg_field paswd;
	
	function new(string name = "vend_paswd_reg");
		super.new(.name( name ), .n_bits(32), .has_coverage(UVM_NO_COVERAGE));
	endfunction
	
	virtual function void build();
		paswd = uvm_reg_field::type_id::create("paswd");
		paswd.configure(.parent                 (this),
                        .size                   (32),
                        .lsb_pos                (0),
                        .access                 ("RW"),
                        .volatile               (0),
                        .reset                  ('hA5A5F00D),
                        .has_reset              (1),
                        .is_rand                (1),
                        .individually_accessible(0)
		);
	endfunction
endclass
`endif