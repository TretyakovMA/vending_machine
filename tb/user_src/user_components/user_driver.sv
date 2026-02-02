`ifndef USER_DRIVER
`define USER_DRIVER
class user_driver extends base_driver #(
	.INTERFACE_TYPE   (virtual user_interface), 
	.TRANSACTION_TYPE (user_transaction      )
);
	`uvm_component_utils(user_driver)


	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new



	task reset();
		vif.id_valid      <= 0;
		vif.client_id     <= 0;
		vif.coin_in       <= 0;
		vif.currency_type <= 0;
		vif.coin_insert   <= 0;
		vif.item_select   <= 0;
		vif.confirm       <= 0;
	endtask: reset
	
	
	virtual task drive_transaction(user_transaction tr);
		vif.id_valid    <= 1; //Сначала клиент совершает вход
		vif.client_id   <= tr.client_id;
		@(posedge vif.clk);

		vif.id_valid    <= 0; //Через такт клиент 
		vif.coin_insert <= 1; //поднимает сигнал coin_insert
		`uvm_info(get_type_name(), "Coin_insert", UVM_HIGH)

		@(posedge vif.clk);
		foreach (tr.coin_in_q[i]) begin
			vif.coin_in       <= tr.coin_in_q[i];       //На каждом такте вносится одна
			vif.currency_type <= tr.currency_type_q[i]; //монета из очереди coin_in_q
			@(posedge vif.clk);
		end
		vif.coin_insert   <= 0;
		vif.coin_in       <= 0;
		vif.currency_type <= 0;
		vif.item_select   <= (1 << tr.item_num);  //Затем выбирается товар
		@(posedge vif.clk);
		
		vif.confirm     <= 1;                    //Через такт поднимается сигнал подтверждения
		@(posedge vif.clk);

		vif.item_select <= 0;
		vif.confirm     <= 0;
		`uvm_info(get_type_name(), {"Send transaction ", tr.convert2string()}, UVM_HIGH)
		repeat(4) @(posedge vif.clk); //Ожидание, пока автомат работает
		reset();                      //На всякий случай все сигналы сбрасываются
	endtask: drive_transaction
		
endclass
`endif