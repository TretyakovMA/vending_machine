`ifndef USER_MONITOR
`define USER_MONITOR
class user_monitor extends uvm_monitor;
	`uvm_component_utils(user_monitor)

	uvm_analysis_port #(user_transaction) ap;

	virtual user_interface vif;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new
	
	
	function void build_phase( uvm_phase phase );
		super.build_phase( phase );
		if(!uvm_config_db #(virtual user_interface)::get(this, "", "user_vif", vif))
			`uvm_fatal("MONITOR", "Faild to get interface")
		ap = new("ap" , this);
	endfunction: build_phase
	
	
	
	typedef enum {IDLE, ACCEPT_COINS, WAIT_CONFIRM, WAIT_ITEM, WAIT_CHANGE} monitor_state_e;
	
	task main_phase(uvm_phase phase);
		user_transaction tr;
		user_transaction copy_tr;
		monitor_state_e state = IDLE;
		forever begin
			@(posedge vif.clk);//добавить проверку на ресет
			
			case(state)
				IDLE: begin	
					wait(vif.id_valid == 1)
					tr = user_transaction::type_id::create("tr");
					tr.client_id = vif.client_id;
					`uvm_info("MONITOR", $sformatf("Client %0d authorized", vif.client_id), UVM_HIGH)
					
					wait (vif.coin_insert);// iff (vif.clk);//добавить срабатывание по posedge clk
					@(posedge vif.clk);
					state = ACCEPT_COINS;
				end
				
				
				
				ACCEPT_COINS: begin
					
					if (vif.item_select == 0) begin
						`uvm_info("MONITOR", $sformatf("Send %0d %s", vif.coin_in, currency_type_t'(vif.currency_type)), UVM_HIGH)
						tr.coin_in_q.push_back(vif.coin_in);
						tr.currency_type_q.push_back(currency_type_t'(vif.currency_type));
					end
					
					else begin
						tr.item_num = $clog2(vif.item_select);
						`uvm_info("MONITOR", $sformatf("Select item = %b", vif.item_select), UVM_HIGH)
						
						state = WAIT_CONFIRM;
					end
				end
				
				
				
				WAIT_CONFIRM: begin
					wait(vif.confirm);
					`uvm_info("MONITOR", {s_send_tr_1, tr.convert2string(), s_send_tr_2}, UVM_LOW)
					repeat(2) @(posedge vif.clk);
					
					state = WAIT_ITEM;
				end
				
				
				
				WAIT_ITEM: begin
					tr.item_out = vif.item_out;
					`uvm_info("MONITOR", $sformatf("Get item = %b", vif.item_out), UVM_HIGH)
					
					state = WAIT_CHANGE;
				end
				
				
				
				WAIT_CHANGE: begin
					tr.change_out = vif.change_out;
					tr.no_change = vif.no_change;
					tr.client_points = vif.client_points;
					`uvm_info("MONITOR", {s_get_tr_1, tr.convert2string(), s_get_tr_2}, UVM_LOW)
					copy_tr = tr.clone_me();
					ap.write(copy_tr);
					
					state = IDLE;
				end
				
			endcase
		end
	endtask: main_phase
	
	
	
	string s_send_tr_1 = "\n\n\n***********************************   Send transaction   ***********************************\nDriver->DUT:\n";
	
	string s_send_tr_2 = "\n********************************************************************************************\n\n";
	
	string s_get_tr_1 = "\n\n\n***********************************   Get transaction   ************************************\nDUT->Scoreboard:\n";
	
	string s_get_tr_2 = "\n********************************************************************************************\n\n";
	
endclass
`endif