`ifndef USER_TRANSACTION
`define USER_TRANSACTION
class user_transaction extends base_transaction;
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
		
		this.client_id       = copied_tr.client_id;
		this.coin_in_q       = copied_tr.coin_in_q;
		this.currency_type_q = copied_tr.currency_type_q;
		this.item_num        = copied_tr.item_num;
		
		this.item_out        = copied_tr.item_out;
		this.change_out      = copied_tr.change_out;
		this.no_change       = copied_tr.no_change;
		this.client_points   = copied_tr.client_points;
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
			`uvm_info("SCOREBOARD", "Points accrued correctly", UVM_HIGH)
		end
		
		same = super.do_compare(rhs, comparer) && same;

		return same;
	endfunction: do_compare
	//************************************************************************************
	
	
	
	//----------------------------------------------------------------------------------
	//Constraint
	constraint valid_client_id{
		client_id < `MAX_CLIENTS;
	}
	
	constraint valid_coin_in{
		coin_in_q.size() dist{
			[1:3]    :/ 40,
			[4:6]    :/ 25,
			[6:10]   :/ 15,
			[11:20]  :/ 15,
			[21:100] :/ 5
		};
		currency_type_q.size() == coin_in_q.size();
		foreach (coin_in_q[i])
			coin_in_q[i] inside {1, 5, 10, 25, 50};
	}
	
	constraint valid_item_select{
		item_num inside {[0:`NUM_ITEMS-1]};
	}
	//----------------------------------------------------------------------------------
endclass
`endif
