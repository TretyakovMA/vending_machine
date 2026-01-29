`ifndef USER_SCOREBOARD
`define USER_SCOREBOARD
class user_scoreboard extends uvm_scoreboard;
	`uvm_component_utils(user_scoreboard)

	
	uvm_analysis_imp #(user_transaction, user_scoreboard) a_imp;

	user_transaction     tr;
	user_transaction     exp_tr;

	vm_reg_block	     reg_block_h;

	local int client_points_db[int];



	
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		a_imp = new("a_imp", this);
	endfunction: build_phase

	task reset_phase(uvm_phase phase);
		super.reset_phase(phase);
		reset_points();
	endtask: reset_phase

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		if(!uvm_config_db #(vm_reg_block)::get(this, "", "reg_block_h", reg_block_h))
			`uvm_fatal(get_type_name(), "Faild to get reg_block_h")
	endfunction: connect_phase

	


	local function void reset_points();
		for (int i = 0; i < `MAX_CLIENTS; i++) begin
			client_points_db[i] = i % 20;
		end
	endfunction: reset_points
	
	

	function shortreal convert_to_rub(bit [5:0] coin, currency_type_t currency);
		bit [1:0] exchange_rate;
		shortreal res;

		exchange_rate = reg_block_h.vend_cfg.exchange_rate.get_mirrored_value();
		case (currency)
			RUB: res = shortreal'(coin);
			USD: res = shortreal'(coin) * exchange_rate;
			EUR: res = shortreal'(coin) * exchange_rate * 1.5;
		endcase

		return res;
	endfunction: convert_to_rub

	function shortreal get_item_price(bit[4:0] item_num, bit [8:0] client_id);
		int           discount;
		shortreal     price;
		bit           vip;
		bit [7:0]     item_discount;

		price         = reg_block_h.vend_item[item_num].item_price.get_mirrored_value();
		item_discount = reg_block_h.vend_item[item_num].item_discount.get_mirrored_value();

		discount = (client_id % 3) * 10;
		vip      = (client_id % 10 == 0);

		if (vip)           discount += 10;
		if (discount > 30) discount = 30;

		price = price - item_discount;
		price = price * (100 - discount) / 100;
		return price;
	endfunction: get_item_price

	function shortreal calculate_balance(bit [5:0] q[$], currency_type_t cur_q[$]);
		shortreal balance = 0;
		
		foreach(q[i]) begin
			//`uvm_info(get_type_name(), $sformatf("Coin %0d of type %s", q[i], currency_type_t'(cur_q[i])), UVM_HIGH)
			balance += convert_to_rub(q[i], cur_q[i]);
		end
		
		return balance;
	endfunction: calculate_balance

	function user_transaction calculate_exp_transaction(user_transaction tr);
		shortreal             balance;
		shortreal             item_price;
		user_transaction      calc_tr;


		calc_tr               = tr.clone_me();
		
		item_price            = get_item_price(calc_tr.item_num, calc_tr.client_id);
		balance               = calculate_balance(calc_tr.coin_in_q, calc_tr.currency_type_q);

		//`uvm_info(get_type_name(), tr.convert2string(), UVM_HIGH)

		//`uvm_info(get_type_name(), $sformatf("Client %0d: balance = %0.2f; item_price = %0.2f", tr.client_id, balance, item_price), UVM_HIGH)


		calc_tr.item_out      = (1 << calc_tr.item_num);
		calc_tr.change_out    = balance - item_price;
		calc_tr.no_change     = (balance - item_price == 0) ? 1 : 0;
		calc_tr.client_points = client_points_db[tr.client_id] + $floor(item_price / 20);

		return calc_tr;
	endfunction: calculate_exp_transaction

	
	
	function void write (user_transaction t);
		if(t.has_reset) begin
			`uvm_info(get_type_name(), "Reset detected", UVM_HIGH)
			reset_points();
			return;
		end

		tr     = t.clone_me();
		exp_tr = calculate_exp_transaction(tr);

		`uvm_info(get_type_name(), `EXP_TR_STR(exp_tr), UVM_LOW)

		if (tr.item_out == 0)
			`uvm_fatal(get_type_name(), "No response from DUT")
		
		
		if(exp_tr.compare(tr)) begin
			`uvm_info(get_type_name(), `RES_SUC_STR, UVM_LOW)
		end
		else begin
			`uvm_info(get_type_name(), `RES_FAILD_STR, UVM_LOW)
		end
		client_points_db[tr.client_id] = exp_tr.client_points;

		`uvm_info(get_type_name(), `END_TEST_STR, UVM_LOW)
	endfunction: write

endclass
`endif