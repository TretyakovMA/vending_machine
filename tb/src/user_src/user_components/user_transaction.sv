`ifndef USER_TRANSACTION
`define USER_TRANSACTION
class user_transaction extends uvm_sequence_item;

	`uvm_object_utils(user_transaction)

	function new(string name = "user_transaction");
		super.new(name);
	endfunction: new



	rand bit [8:0]        client_id;
	rand bit [5:0]        coin_in_q[$];
	rand currency_type_t  currency_type_q[$];
	rand bit [4:0]        item_num;
	
	bit [`NUM_ITEMS-1:0]  item_out;
	bit [31:0]            change_out;
	bit                   no_change;
	bit [7:0]             client_points;

	bit [`NUM_ITEMS-1:0]  item_empty;
	
	
	
	//================================ DO-HOOKS ===================================
	
	virtual function void do_print(uvm_printer printer);
		super.do_print(printer);  // печать полей базового класса

		// Простые поля
		printer.print_field("client_id", client_id, $bits(client_id), UVM_DEC);
		printer.print_field("item_num",  item_num,  $bits(item_num),  UVM_DEC);
		printer.print_field("item_out",  item_out,  $bits(item_out),  UVM_BIN);
		printer.print_field("change_out", change_out, $bits(change_out), UVM_DEC);
		printer.print_field("no_change", no_change, $bits(no_change), UVM_BIN);
		printer.print_field("client_points", client_points, $bits(client_points), UVM_DEC);
		printer.print_field("item_empty", item_empty, $bits(item_empty), UVM_BIN);


		// Очередь монет и типов валют вместе (coin_in_q + currency_type_q)
		printer.print_array_header("coin_in", coin_in_q.size());
		foreach (coin_in_q[i]) begin
			printer.print_string(
				$sformatf("[%0d]", i), 
			    $sformatf("%2d %s", coin_in_q[i], currency_type_q[i].name())
			);
		end
		printer.print_array_footer();

	endfunction: do_print

	
	
	function string convert2string();
		int    size;
		int    num_rows;
		int    num_cols;
		string line;

		string s = "-------------------- Input -------------------\n";
		s = {s, $sformatf("  Client_id     = %0d\n", client_id)};
		s = {s, $sformatf("  item_num      = %0d\n", item_num)};
		s = {s, "  Coins in:\n"};
		
		size = coin_in_q.size();
			
		num_rows = (size - 1) / 10 + 1;
		num_cols = size < 10 ? size: 10;
			
		for(int i = 0; i < num_cols; i++) begin
			line = "";
			for(int j = 0; j < num_rows; j++) begin
				if (i + j*10 < size) begin
					line = {line, $sformatf("  [%2d] %2d %s", i + j*10, coin_in_q[i + j*10], currency_type_q[i + j*10].name())};
				end
			end
			s = {s, line, "\n"};
		end	
		
		
		s = {s, "-------------------- Output ------------------\n"};
		s = {s, $sformatf("  item_out      = %b\n", item_out)};
		s = {s, $sformatf("  change_out    = %0d\n", change_out)};
		s = {s, $sformatf("  no_change     = %b\n", no_change)};
		s = {s, $sformatf("  client_points = %0d\n", client_points)};
		s = {s, $sformatf("  item_empty    = %b\n", item_empty)};
		s = {s, "----------------------------------------------"};
		
		return s;
	endfunction: convert2string
	
	function void do_copy(uvm_object rhs);
		user_transaction copied_tr;
		
		if(rhs == null)
			`uvm_fatal(get_type_name(), "Tried to copy from a null pointer")
		if(!$cast(copied_tr, rhs))
			`uvm_fatal(get_type_name(), "Tried to copy wrong type")
		
		super.do_copy(rhs);
		
		this.client_id       = copied_tr.client_id;
		this.coin_in_q       = copied_tr.coin_in_q;
		this.currency_type_q = copied_tr.currency_type_q;
		this.item_num        = copied_tr.item_num;
		
		this.item_out        = copied_tr.item_out;
		this.change_out      = copied_tr.change_out;
		this.no_change       = copied_tr.no_change;
		this.client_points   = copied_tr.client_points;
		
		this.item_empty      = copied_tr.item_empty;
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
			`uvm_fatal(get_type_name(), "Tried to do comparsion to a null pointer")
		if (!$cast(compared_tr, rhs)) same = 0;
		
		if (this.item_out != compared_tr.item_out) begin
			same = 0;
			`uvm_error(get_type_name(), {"Item issuance error:\nGet transaction:\n", compared_tr.convert2string(), "\nExpected:\n", this.convert2string()})
		end
		else begin
			`uvm_info(get_type_name(), "Item issued correctly", UVM_HIGH)
		end
		
		if (this.change_out != compared_tr.change_out) begin
			same = 0;
			`uvm_error(get_type_name(), {"Change issued error:\nGet transaction:\n", compared_tr.convert2string(), "\nExpected:\n", this.convert2string()})
		end
		else begin
			`uvm_info(get_type_name(), "Change issued correctly", UVM_HIGH)
		end
		
		if (this.no_change != compared_tr.no_change) begin
			same = 0;
			`uvm_error(get_type_name(), {"No_change signal error:\nGet transaction:\n", compared_tr.convert2string(), "\nExpected:\n", this.convert2string()})
		end
		else begin
			`uvm_info(get_type_name(), "No_change signal correctly", UVM_HIGH)
		end
		
		if (this.client_points != compared_tr.client_points) begin
			same = 0;
			`uvm_error(get_type_name(), {"Points accrual error:\nGet transaction:\n", compared_tr.convert2string(), "\nExpected:\n", this.convert2string()})
		end
		else begin
			`uvm_info(get_type_name(), "Points accrued correctly", UVM_HIGH)
		end
		
		same = super.do_compare(rhs, comparer) && same;

		return same;
	endfunction: do_compare
	
	
	
	//================================= CONSTRAINTS =======================================
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
	
endclass
`endif
