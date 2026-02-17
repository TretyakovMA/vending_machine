`ifndef VEND_CFG_REG
`define VEND_CFG_REG
class vend_cfg_reg extends uvm_reg;
	`uvm_object_utils(vend_cfg_reg)
	
	uvm_reg_field      reserved;  
	rand uvm_reg_field exchange_rate;
	rand uvm_reg_field idle_timeout;
	rand uvm_reg_field max_coins;
	uvm_reg_field      num_items; 
    
    constraint valid_exchange_rate {
        exchange_rate.value > 0;
    }     
	
	function new(string name = "vend_cfg_reg");
		super.new(.name( name ), .n_bits(32), .has_coverage(UVM_NO_COVERAGE));
	endfunction
	
	virtual function void build();
		reserved = uvm_reg_field::type_id::create("reserved");
		reserved.configure(
            .parent                 (this),
            .size                   (6),
            .lsb_pos                (26),
            .access                 ("RO"),
            .volatile               (0),
            .reset                  ('h0),
            .has_reset              (1),
            .is_rand                (0),
            .individually_accessible(0)
		);
		
		exchange_rate = uvm_reg_field::type_id::create("exchange_rate");
		exchange_rate.configure(
            .parent                 (this),
            .size                   (2),
            .lsb_pos                (24),
            .access                 ("RW"),
            .volatile               (0),
            .reset                  ('h02),
            .has_reset              (1),
            .is_rand                (1),
            .individually_accessible(0)
		);
		
		idle_timeout = uvm_reg_field::type_id::create("idle_timeout");
		idle_timeout.configure(
            .parent                 (this),
            .size                   (11),
            .lsb_pos                (13),
            .access                 ("RW"),
            .volatile               (0),
            .reset                  ('h78),
            .has_reset              (1),
            .is_rand                (1),
            .individually_accessible(0)
		);
    
		max_coins = uvm_reg_field::type_id::create("max_coins");
		max_coins.configure(
            .parent                 (this),
            .size                   (8),
            .lsb_pos                (5),
            .access                 ("RW"),
            .volatile               (0),
            .reset                  ('h64),
            .has_reset              (1),
            .is_rand                (1),
            .individually_accessible(0)
		);
    
		num_items = uvm_reg_field::type_id::create("num_items");
		num_items.configure(
            .parent                 (this),
            .size                   (5),
            .lsb_pos                (0),
            .access                 ("RW"),
            .volatile               (0),
            .reset                  ('hA),
            .has_reset              (1),
            .is_rand                (0),
            .individually_accessible(0)
		);
	endfunction
endclass
`endif