`ifndef VEND_CLIENTS_REG
`define VEND_CLIENTS_REG
class vend_clients_reg extends uvm_reg;
	`uvm_object_utils(vend_clients_reg)
	
	uvm_reg_field reserved;
	uvm_reg_field max_clients;
	
	function new(string name = "vend_clients_reg");
		super.new(.name(name), .n_bits(32), .has_coverage(UVM_NO_COVERAGE));
	endfunction
	
	virtual function void build();
		reserved = uvm_reg_field::type_id::create("reserved");
		reserved.configure(
            .parent                 (this),
            .size                   (24),
            .lsb_pos                (8),
            .access                 ("RO"),
            .volatile               (0),
            .reset                  ('h0),
            .has_reset              (1),
            .is_rand                (0),
            .individually_accessible(0)
		);
		
		max_clients = uvm_reg_field::type_id::create("max_clients");
		max_clients.configure(
            .parent                 (this),
            .size                   (8),
            .lsb_pos                (0),
            .access                 ("RW"),
            .volatile               (0),
            .reset                  ('h64),
            .has_reset              (1),
            .is_rand                (0),
            .individually_accessible(0)
		);
	endfunction
endclass
`endif