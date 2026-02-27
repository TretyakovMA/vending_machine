`ifndef USER_DRIVER
`define USER_DRIVER
class user_driver extends vm_base_driver #(
	.INTERFACE_TYPE   (virtual user_interface), 
	.TRANSACTION_TYPE (user_transaction      )
);
	`uvm_component_utils(user_driver)

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new



	`uvm_register_cb(user_driver, user_driver_cb)

	task reset();
		vif.id_valid      <= 0;
		vif.client_id     <= 0;
		vif.coin_in       <= 0;
		vif.currency_type <= 0;
		vif.coin_insert   <= 0;
		vif.item_select   <= 0;
		vif.confirm       <= 0;
	endtask: reset
	
	
	task drive_transaction(user_transaction tr);
		// Сначала клиент совершает вход
		vif.id_valid    <= 1; 
		vif.client_id   <= tr.client_id;
		`uvm_info(get_type_name(), $sformatf("Client %0d authorized", tr.client_id), UVM_HIGH)
		@(posedge vif.clk);

		// Через такт клиент поднимает сигнал coin_insert
		vif.id_valid    <= 0; 
		vif.coin_insert <= 1;
		`uvm_info(get_type_name(), "Coin_insert", UVM_HIGH)
		@(posedge vif.clk);

		// На каждом такте вносится одна монета из очереди coin_in_q
		foreach (tr.coin_in_q[i]) begin
			vif.coin_in       <= 0;
			vif.currency_type <= 0;
			`uvm_do_callbacks(user_driver, user_driver_cb, delay_in_coin_deposit(vif))
			
			vif.coin_in       <= tr.coin_in_q[i];       
			vif.currency_type <= tr.currency_type_q[i]; 
			@(posedge vif.clk);
		end
		vif.coin_insert   <= 0;
		vif.coin_in       <= 0;
		vif.currency_type <= 0;

		// Затем выбирается товар
		vif.item_select   <= (1 << tr.item_num);  
		@(posedge vif.clk);
		
		// Через такт поднимается сигнал подтверждения
		vif.confirm       <= 1;                    
		@(posedge vif.clk);

		// Ожидание, пока автомат работает
		vif.item_select   <= 0;
		vif.confirm       <= 0;
		`uvm_info(get_type_name(), {"Send transaction:\n", tr.convert2string()}, UVM_HIGH)
		repeat(4) @(posedge vif.clk); 
		
		reset(); //На всякий случай все сигналы сбрасываются
		@(posedge vif.clk);
	endtask: drive_transaction
		
endclass
`endif