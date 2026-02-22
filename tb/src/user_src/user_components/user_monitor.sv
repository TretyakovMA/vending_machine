`ifndef USER_MONITOR
`define USER_MONITOR
class user_monitor extends vm_base_monitor #(
	.INTERFACE_TYPE   (virtual user_interface), 
	.TRANSACTION_TYPE (user_transaction      )
);
	`uvm_component_utils(user_monitor)

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new
	

	//Начинаем мониторинг, когда клиент вошел в систему
	task wait_for_sampling_event(); 
        @(posedge vif.clk iff vif.id_valid == 1);
    endtask: wait_for_sampling_event

	task collect_transaction_data (user_transaction tr);
		// Сначала фиксируем ID клиента
		tr.client_id = vif.client_id; 
		`uvm_info(get_type_name(), $sformatf("Client %0d authorized", vif.client_id), UVM_HIGH)
		
		// Ждем сигнала coin_insert
		@(posedge vif.clk iff vif.coin_insert);
		
		repeat(1) @(posedge vif.clk);
		
		// Фиксируем монеты, пока не выбран товар
		while (vif.item_select == 0) begin 
			`uvm_info(get_type_name(), $sformatf("Send %0d %s", vif.coin_in, currency_type_t'(vif.currency_type)), UVM_HIGH)
			if(vif.coin_in != 0) begin
				tr.coin_in_q.push_back(vif.coin_in);
				tr.currency_type_q.push_back(currency_type_t'(vif.currency_type));
			end
			@(posedge vif.clk);
		end
		
		// Фиксируем выбранный товар
		tr.item_num = $clog2(vif.item_select); 
		`uvm_info(get_type_name(), $sformatf("Select item = %b", vif.item_select), UVM_HIGH)
		
		// Ждем сигнал подтверждения
		@(posedge vif.clk iff vif.confirm);    
		`uvm_info(get_type_name(), `SEND_TR_STR(tr), UVM_LOW)
		
		// Ждем, пока автомат обработает запрос
		repeat(3) @(posedge vif.clk);          



		// Если товара нет (поднят сигнал item_empty), то, наверное, сдачи не будет
		// точного поведения в спецификации пока нет, так что оставлю в таком виде
		if(vif.item_empty) begin
			tr.item_empty = vif.item_empty;
			return;
		end

		// Если все нормально
		// Фиксируем выданный товар
		tr.item_out      = vif.item_out;       
		`uvm_info(get_type_name(), $sformatf("Get item = %b", vif.item_out), UVM_HIGH)
		@(posedge vif.clk);

		// Фиксируем выданные сдачу и очки
		tr.change_out    = vif.change_out;     
		tr.no_change     = vif.no_change;
		tr.client_points = vif.client_points;

	endtask: collect_transaction_data
	
endclass
`endif