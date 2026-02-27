`ifndef VM_SCOREBOARD
`define VM_SCOREBOARD

`uvm_analysis_imp_decl(_RESET)
`uvm_analysis_imp_decl(_USER)
`uvm_analysis_imp_decl(_EMERGENCY)

class vm_scoreboard extends uvm_scoreboard;
	`uvm_component_utils(vm_scoreboard)

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new

	uvm_analysis_imp_RESET #(reset_transaction, vm_scoreboard) reset_imp;
	uvm_analysis_imp_USER #(user_transaction, vm_scoreboard) user_imp;
	uvm_analysis_imp_EMERGENCY #(emergency_transaction, vm_scoreboard) emergency_imp;

	// Класс для проверки пользовательской транзакции
	local user_checker       checker_h;

	// Текущая и ожидаемая пользовательские транзакции
	local user_transaction   tr;
	local user_transaction   exp_tr;

	// БД накопленных очков клиентов
	local int                client_points_db[int]; 

	// Регистровая модель
	local vm_reg_block       reg_block_h;

	// Флаг наличия сигнала прерывания в время пользовательской сессии
	local bit                emergency_occurred = 0; 

	// Флаг того, что в тесте используется регистровая модель (устанавливается в env)
	bit                      has_reg_model; 

	// Переменные для изменения количества товаров после покупки
	local int                item_count;
	local int                item_id;


	// Функция сброса БД очков клиентов
	local function void reset_points(); 
		`uvm_info (get_type_name(), "Resetting client points database", UVM_HIGH)
		for (int i = 0; i < `MAX_CLIENTS; i++) begin
			client_points_db[i] = i % 20;
		end
	endfunction: reset_points
	
	//============================== Фазы UVM ====================================
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		reset_imp     = new("reset_imp", this);
		user_imp      = new("user_imp", this);
		emergency_imp = new("emergency_imp", this);
	endfunction: build_phase

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		
		// Поиск чекера
		if(!uvm_config_db #(user_checker)::get(this, "", "user_checker", checker_h))
			`uvm_fatal(get_type_name(), "Faild to get user_checker_h")
		
		// Поиск регистровой модели 
		if(has_reg_model) begin
			if(!uvm_config_db #(vm_reg_block)::get(this, "", "reg_block", reg_block_h))
				`uvm_fatal(get_type_name(), "Failed to get reg_block")
			
			// Чекер получает регистровую модель
			checker_h.reg_block_h = reg_block_h;
		end
	endfunction: connect_phase

	task reset_phase(uvm_phase phase);
		super.reset_phase(phase);
		// Сброс очков и регистровой модели
		reset_points();
		if(has_reg_model)
			reg_block_h.reset();
	endtask: reset_phase
	


	//==========================  Обработка транзакций  ============================= 

	// Реакция на сигнал сброса
	function void write_RESET (reset_transaction t); 
		`uvm_info(get_type_name(), "Reset detected", UVM_HIGH)
		reg_block_h.reset();
		reset_points();
		emergency_occurred = 0;
		`uvm_info(get_type_name(), `END_TEST_STR, UVM_LOW)
	endfunction: write_RESET
	

	// Обработка транзакций сигналов прерывания
	function void write_EMERGENCY (emergency_transaction t);
		
		if (t.tamper_detect || t.jam_detect || t.power_loss) begin
			emergency_occurred = 1;
			`uvm_info(get_type_name(), "Emergency event detected (tamper/jam/power_loss)", UVM_LOW)
		end
		else emergency_occurred = 0;

		if ((t.alarm != 1) && (t.tamper_detect || t.jam_detect || t.power_loss)) begin
			`uvm_error(get_type_name(), "Alarm is not set to 1")
		end
	endfunction: write_EMERGENCY
	
	// Обработка пользовательских транзакций
	function void write_USER (user_transaction t);

		tr = t.clone_me(); //Работаем с копией транзакции

		// Если за время пользовательской сессии появлялся
		// сигнал сбоя, то устройство должно перестать работать
		if (emergency_occurred) begin
			if (tr.item_out   != 0)
				`uvm_error(get_type_name(), $sformatf("Error occurred but item_out = %b", tr.item_out))

			if (tr.change_out != 0)
				`uvm_error(get_type_name(), $sformatf("Error occurred but change_out = %0d", tr.change_out))
			
			if(tr.no_change != 0)
				`uvm_error(get_type_name(), $sformatf("Error occurred but no_change = %b", tr.no_change))

			`uvm_info(get_type_name(), `END_TEST_STR, UVM_LOW)
			return;
		end

		// Если была попытка купить закончившийся товар, то должен быть сигнал item_empty
		item_id    = $clog2(tr.item_out);
		item_count = reg_block_h.vend_item[item_id].item_count.get();

		// Если сигнала нет, а регистровая модель говорит что товар закончился, то это ошибка
		if (item_count == 0 && (tr.item_empty != tr.item_out)) begin
			`uvm_error(get_type_name(), $sformatf("The item_empty signal is incorrect; should be: %b", tr.item_out))
			`uvm_info(get_type_name(), `RES_FAILD_STR, UVM_LOW)
			`uvm_info(get_type_name(), `END_TEST_STR, UVM_LOW)
			return;
		end
		// Если сигнал корректен, то обработка завершается
		else if (item_count == 0) begin
			`uvm_info(get_type_name(), `RES_SUC_STR, UVM_LOW)
			`uvm_info(get_type_name(), `END_TEST_STR, UVM_LOW)
			return;
		end



		//==================  Нормальная пользовательская сессия  ==================
		
		// Если из DUT не пришел товар, то симуляция завершается
		if (tr.item_out == 0) 
			`uvm_fatal(get_type_name(), "No response from DUT")


		// Расчет ожидаемой транзакции
		exp_tr = checker_h.calculate_exp_transaction(tr, client_points_db[tr.client_id]);
		
		`uvm_info(get_type_name(), `EXP_TR_STR(exp_tr), UVM_MEDIUM)
		

		// Сравнение транзакций
		if(exp_tr.compare(tr)) begin 
			`uvm_info(get_type_name(), `RES_SUC_STR, UVM_LOW)
		end
		else begin
			`uvm_info(get_type_name(), `RES_FAILD_STR, UVM_LOW)
		end

		// Обновление БД очков
		client_points_db[tr.client_id] = exp_tr.client_points; 

		// Уменьшение количества товаров после покупки
		void'(reg_block_h.vend_item[item_id].item_count.predict(item_count - 1));

		`uvm_info(get_type_name(), `END_TEST_STR, UVM_LOW)
	endfunction: write_USER

endclass
`endif