`ifndef USER_DRIVER
`define USER_DRIVER
class user_driver extends base_driver #(virtual user_interface, user_transaction);
	`uvm_component_utils(user_driver)


	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new



	task reset();
		vif.id_valid <= 0;
		vif.client_id <= 0;
		vif.coin_in <= 0;
		vif.currency_type <= 0;
		vif.coin_insert <= 0;
		vif.item_select <= 0;
		vif.confirm <= 0;
	endtask: reset
	
	
	virtual task drive_transaction(user_transaction tr);
		vif.id_valid <= 1;
		vif.client_id <= tr.client_id;
		repeat(1) @(posedge vif.clk);
		vif.id_valid <= 0;
		vif.coin_insert <= 1;
		`uvm_info("DRIVER", "Coin_insert", UVM_HIGH)
		repeat(1) @(posedge vif.clk);
		foreach (tr.coin_in_q[i]) begin
			vif.coin_in <= tr.coin_in_q[i];
			vif.currency_type <= tr.currency_type_q[i];
			repeat(1) @(posedge vif.clk);
		end
		vif.coin_insert <= 0;
		vif.coin_in <= 0;
		vif.item_select <= (1 << tr.item_num); 
		repeat(1) @(posedge vif.clk);
		
		vif.confirm <= 1;
		repeat(1) @(posedge vif.clk);
		vif.item_select <= 0;
		vif.confirm <= 0;
		repeat(4) @(posedge vif.clk);
		
	endtask: drive_transaction
		
endclass
`endif