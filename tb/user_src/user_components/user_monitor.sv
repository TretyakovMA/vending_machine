`ifndef USER_MONITOR
`define USER_MONITOR
class user_monitor extends muvc_monitor #(
	virtual user_interface, 
	user_transaction
);
	`uvm_component_utils(user_monitor)

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new
	
	
	function bit condition ();
		return vif.id_valid == 1;
	endfunction: condition

	task reset();
		user_scoreboard::reset_points();
	endtask: reset

	task monitoring_transaction (user_transaction tr);
		tr.client_id = vif.client_id;
		`uvm_info(get_type_name(), $sformatf("Client %0d authorized", vif.client_id), UVM_HIGH)
		@(posedge vif.clk iff vif.coin_insert);
		
		repeat(1) @(posedge vif.clk);
		
		while (vif.item_select == 0) begin
			`uvm_info(get_type_name(), $sformatf("Send %0d %s", vif.coin_in, currency_type_t'(vif.currency_type)), UVM_HIGH)
			tr.coin_in_q.push_back(vif.coin_in);
			tr.currency_type_q.push_back(currency_type_t'(vif.currency_type));
			@(posedge vif.clk);
		end
		
		tr.item_num = $clog2(vif.item_select);
		`uvm_info(get_type_name(), $sformatf("Select item = %b", vif.item_select), UVM_HIGH)
		
		@(posedge vif.clk iff vif.confirm);
		
		//`uvm_info(get_type_name(), {s_send_tr_1, tr.convert2string(), s_send_tr_2}, UVM_LOW)
		`muvc_tr_info("MUVC_SEND_TR", tr, UVM_LOW)
		repeat(3) @(posedge vif.clk);
		
		tr.item_out = vif.item_out;
		`uvm_info(get_type_name(), $sformatf("Get item = %b", vif.item_out), UVM_HIGH)
		@(posedge vif.clk);

		tr.change_out = vif.change_out;
		tr.no_change = vif.no_change;
		tr.client_points = vif.client_points;
		//`uvm_info(get_type_name(), {s_get_tr_1, tr.convert2string(), s_get_tr_2}, UVM_LOW)
	endtask: monitoring_transaction
	
	
	
	//string s_send_tr_1 = "\n***********************************   Send transaction   ***********************************\nDriver->DUT:\n";
	
	//string s_send_tr_2 = "\n********************************************************************************************";
	
	//string s_get_tr_1 = "\n***********************************   Get transaction   ************************************\nDUT->Scoreboard:\n";
	
	//string s_get_tr_2 = "\n********************************************************************************************";
	
endclass
`endif