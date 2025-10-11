`ifndef VEND_ITEM_REG
`define VEND_ITEM_REG
class vend_item_reg extends uvm_reg;
	`uvm_object_utils(vend_item_reg)
	
	uvm_reg_field reserved;
	rand uvm_reg_field item_discount;
	rand uvm_reg_field item_count;
	rand uvm_reg_field item_price;

    constraint valid_discount {
        item_discount.value < item_price.value;
    }

    
	
	function new(string name = "vend_item_reg");
		super.new(.name(name), .n_bits(32), .has_coverage(UVM_NO_COVERAGE));
	endfunction
	
	virtual function void build();
		reserved = uvm_reg_field::type_id::create("reserved");
		reserved.configure(.parent              (this),
                        .size                   (8),
                        .lsb_pos                (24),
                        .access                 ("RO"),
                        .volatile               (0),
                        .reset                  ('h0),
                        .has_reset              (1),
                        .is_rand                (0),
                        .individually_accessible(0)
		);
		
		item_discount = uvm_reg_field::type_id::create("item_discount");
		item_discount.configure(.parent         (this),
                        .size                   (8),
                        .lsb_pos                (16),
                        .access                 ("RW"),
                        .volatile               (0),
                        .reset                  ('h0),
                        .has_reset              (1),
                        .is_rand                (1),
                        .individually_accessible(0)
		);
		
		item_count = uvm_reg_field::type_id::create("item_count");
		item_count.configure(.parent            (this),
                        .size                   (8),
                        .lsb_pos                (8),
                        .access                 ("RW"),
                        .volatile               (0),
                        .reset                  ('h5),
                        .has_reset              (1),
                        .is_rand                (1),
                        .individually_accessible(0)
		);
		
		item_price = uvm_reg_field::type_id::create("item_price");
		item_price.configure(.parent            (this),
                        .size                   (8),
                        .lsb_pos                (0),
                        .access                 ("RW"),
                        .volatile               (0),
                        .reset                  ('h0),//настраивается в reg_block
                        .has_reset              (1),
                        .is_rand                (1),
                        .individually_accessible(0)
		);
	endfunction
endclass
`endif