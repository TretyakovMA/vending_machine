`ifndef USER_TRANSACTION
`define USER_TRANSACTION
class user_transaction extends uvm_sequence_item;
	`uvm_object_utils(user_transaction)
	rand bit [8:0]        client_id;
	rand bit [5:0]        coin_in_q[$];
	rand currency_type_t  currency_type_q[$];
	rand bit [4:0]        item_num;
	
	bit [`NUM_ITEMS-1:0]  item_out;
	bit [31:0]            change_out;
	bit                   no_change;
	bit [7:0]             client_points;
	
	
	function new(string name = "");
		super.new(name);
	endfunction: new
	
	
	static int client_points_db[int];//подумать над переносом
	
	static function void reset_points();
		for (int i = 0; i < `MAX_CLIENTS; i++) begin
			client_points_db[i] = i % 20;
		end
	endfunction: reset_points
	
	
	
	
	//************************************************************************************
	//Do-hooks
	function string convert2string();
		string s;
		s = $sformatf("Client_id = %0d; coin_in = %p; currency_type = %p; item_num = %0d; item_out = %b; change_out = %0d; no_change = %b; client_points = %0d",
			client_id, coin_in_q, currency_type_q, item_num, item_out, change_out, no_change, client_points);
		return s;
	endfunction: convert2string
	
	
	
	function void do_copy(uvm_object rhs);
		user_transaction copied_tr;
		
		if(rhs == null)
			`uvm_fatal("USER_TRANSACTION", "Tried to copy from a null pointer")
		if(!$cast(copied_tr, rhs))
			`uvm_fatal("USER_TRANSACTION", "Tried to copy wrong type")
		
		super.do_copy(rhs);
		
		this.client_id = copied_tr.client_id;
		this.coin_in_q = copied_tr.coin_in_q;
		this.currency_type_q = copied_tr.currency_type_q;
		this.item_num = copied_tr.item_num;
		
		this.item_out = copied_tr.item_out;
		this.change_out = copied_tr.change_out;
		this.no_change = copied_tr.no_change;
		this.client_points = copied_tr.client_points;
	endfunction: do_copy
	
	
	function user_transaction clone_me();
		user_transaction clone;
		uvm_object tmp;
		
		tmp = this.clone();
		$cast(clone, tmp);
		return clone;
	endfunction: clone_me
	
	
	function bit do_compare (uvm_object rhs, uvm_comparer comparer);
		user_transaction compared_tr;
		bit same = 1;
		
		if(rhs == null)
			`uvm_fatal("USER_TRANSACTION", "Tried to do comparsion to a null pointer")
		if (!$cast(compared_tr, rhs)) same = 0;
		
		
		if (this.item_out != compared_tr.item_out) begin
			same = 0;
			`uvm_error("SCOREBOARD", $sformatf("Item issuance error: item_out = %b, expected = %b", compared_tr.item_out, this.item_out))
		end
		else begin
			`uvm_info("SCOREBOARD", "Item issued correctly", UVM_HIGH)
		end
		
		
		if (this.change_out != compared_tr.change_out) begin
			same = 0;
			`uvm_error("SCOREBOARD", $sformatf("Change issued error: change_out = %0d, expected = %0d", compared_tr.change_out, this.change_out))
		end
		else begin
			`uvm_info("SCOREBOARD", "Change issued correctly", UVM_HIGH)
		end
		
		
		if (this.no_change != compared_tr.no_change) begin
			same = 0;
			`uvm_error("SCOREBOARD", $sformatf("No_change signal error: no_change = %b, expected = %b", compared_tr.no_change, this.no_change))
		end
		else begin
			`uvm_info("SCOREBOARD", "No_change signal correctly", UVM_HIGH)
		end
		
		
		if (this.client_points != compared_tr.client_points) begin
			same = 0;
			`uvm_error("SCOREBOARD", $sformatf("Points accrual error: client_points = %0d, expected = %0d", compared_tr.client_points, this.client_points))
		end
		else begin
			client_points_db[client_id] = compared_tr.client_points;
			`uvm_info("SCOREBOARD", "Points accrued correctly", UVM_HIGH)
		end
		
		
		same = super.do_compare(rhs, comparer) && same;
		
		return same;
	endfunction: do_compare
	//************************************************************************************
	
	
	
	
	
	

	
	//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	//Calculate expected transaction
	function int convert_to_rub(bit [5:0] coin, currency_type_t currency);
		case (currency)
			RUB: return coin;
			USD: return coin * 2;
			EUR: return coin * 3;
		endcase
	endfunction: convert_to_rub
	
	
	
	function int get_item_price(bit[4:0] item_num, bit [8:0] client_id);
		int discount;
		int price;
		bit vip;
		discount = (client_id % 3) * 10;
		vip = (client_id % 10 == 0);
		if (vip) discount += 10;
		if (discount > 30) discount = 30;
		price = (item_num + 1) * 10;
		
		price = price * (100 - discount) / 100;
		return price;
	endfunction: get_item_price
	
	
	
	function int calculate_balance(bit [5:0] q[$], currency_type_t cur_q[$]);
		int balance = 0;
		
		foreach(q[i])
			balance += convert_to_rub(q[i], cur_q[i]);
		
		return balance;
	endfunction: calculate_balance
	
	
	
	
	function void calculate_exp_transaction();
		int balance;
		int item_price;
		
		item_price = get_item_price(item_num, client_id);
		balance = calculate_balance(coin_in_q, currency_type_q);
		
		item_out = (1 << item_num);
		change_out = balance - item_price;
		no_change = (balance - item_price == 0) ? 1 : 0;
		client_points = client_points_db[client_id] + $floor(item_price / 20);
	endfunction: calculate_exp_transaction
	//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	
	
	
	
	
	//----------------------------------------------------------------------------------
	//Constraint
	constraint valid_client_id{
		client_id < `MAX_CLIENTS;
	}
	
	constraint valid_coin_in{
		coin_in_q.size() inside {[1:100]};
		currency_type_q.size() == coin_in_q.size();
		foreach (coin_in_q[i])
			coin_in_q[i] inside {1, 5, 10, 25, 50};
	}
	
	constraint valid_item_select{
		item_num inside {[0:`NUM_ITEMS-1]};
	}
	
	/*constraint valid_balance{
		calculate_balance(coin_in_q, currency_type_q) >= get_item_price(item_num, client_id);
	}*/
	
	
	//----------------------------------------------------------------------------------
	
endclass
`endif
