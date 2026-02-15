`ifndef VM_SCOREBOARD
`define VM_SCOREBOARD

`uvm_analysis_imp_decl(_ERROR)
`uvm_analysis_imp_decl(_USER)
`uvm_analysis_imp_decl(_REGISTER)

class vm_scoreboard extends uvm_scoreboard;
	`uvm_component_utils(vm_scoreboard)

	uvm_analysis_imp_USER #(user_transaction, vm_scoreboard) user_imp;
	uvm_analysis_imp_ERROR #(error_transaction, vm_scoreboard) error_imp;
	uvm_analysis_imp_REGISTER #(register_transaction, vm_scoreboard) register_imp;

	//Класс для проверки пользовательской транзакции
	local user_checker       checker_h;

	local user_transaction   tr;
	local user_transaction   exp_tr;

	//БД накопленных очков клиентов
	local int                client_points_db[int]; 

	//Регистровая модель
	local vm_reg_block       reg_block_h;

	//Флаг наличия сигнала прерывания в время пользовательской сессии
	local bit                error_occurred = 0; 

	//Флаг того, что в тесте используется регистровая модель (устанавливается в env)
	bit                      has_reg_model; 


	
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new
	
	//Фазы UVM
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		user_imp     = new("user_imp", this);
		error_imp    = new("error_imp", this);
		register_imp = new("register_imp", this);
	endfunction: build_phase

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		
		//Поиск чекера
		if(!uvm_config_db #(user_checker)::get(this, "", "user_checker", checker_h))
			`uvm_fatal(get_type_name(), "Faild to get user_checker_h")
		
		//Поиск регистровой модели 
		if(has_reg_model) begin
			if(!uvm_config_db #(vm_reg_block)::get(this, "", "reg_block", reg_block_h))
				`uvm_fatal(get_type_name(), "Failed to get reg_block")
			
			checker_h.reg_block_h = reg_block_h;//Чекер получает регистровую модель
		end
	endfunction: connect_phase

	task reset_phase(uvm_phase phase);
		super.reset_phase(phase);
		//Сброс очков и регистровой модели
		reset_points();
		if(has_reg_model)
			reg_block_h.reset();
	endtask: reset_phase

	

	//Функция сброса БД очков клиентов
	local function void reset_points(); 
		`uvm_info (get_type_name(), "Resetting client points database", UVM_HIGH)
		for (int i = 0; i < `MAX_CLIENTS; i++) begin
			client_points_db[i] = i % 20;
		end
	endfunction: reset_points
	


	//==========================  Обработка транзакций  ============================= 

	//Обработка регистровых транзакций
	function void write_REGISTER (register_transaction t);
		if(t.has_reset) begin
			`uvm_info(get_type_name(), "Reset detected", UVM_HIGH)
			reg_block_h.reset();
		end
	endfunction: write_REGISTER

	//Обработка транзакций сигналов прерывания
	function void write_ERROR (error_transaction t);
		if ((t.tamper_detect || t.jam_detect || t.power_loss) && !error_occurred) begin
			error_occurred = 1;
			`uvm_info(get_type_name(), "Error event detected (tamper/jam/power_loss)", UVM_LOW)
		end

		if ((t.alarm != 1) && (t.tamper_detect || t.jam_detect || t.power_loss)) begin
			`uvm_error(get_type_name(), "Alarm is not set to 1")
		end
	endfunction: write_ERROR
	
	//Обработка пользовательских транзакций
	function void write_USER (user_transaction t);
		//если приходит транзакция с флагом rst, сбрасываем очки и не продолжаем обработку
		if(t.has_reset) begin   
			reset_points(); 
			error_occurred = 0; 
			return;         
		end

		tr = t.clone_me(); //Работаем с копией транзакции


		// Если за время пользовательской сессии появлялся
		// сигнал сбоя, то устройство должно перестать работать
		if (error_occurred) begin
			if (tr.item_out   != 0)
				`uvm_error(get_type_name(), $sformatf("Error occurred but item_out = %b", tr.item_out))

			if (tr.change_out != 0)
				`uvm_error(get_type_name(), $sformatf("Error occurred but change_out = %0d", tr.change_out))

			error_occurred = 0;
			return;
		end



		//==================  Нормальная пользовательская сессия  ==================
		
		//Если из DUT не пришел товар, то симуляция завершается
		if (tr.item_out == 0) 
			`uvm_fatal(get_type_name(), "No response from DUT")

		//Расчет ожидаемой транзакции
		exp_tr = checker_h.calculate_exp_transaction(tr, client_points_db[tr.client_id]);
		`uvm_info(get_type_name(), `EXP_TR_STR(exp_tr), UVM_LOW)
		
		//Сравнение транзакций
		if(exp_tr.compare(tr)) begin 
			`uvm_info(get_type_name(), `RES_SUC_STR, UVM_LOW)
		end
		else begin
			`uvm_info(get_type_name(), `RES_FAILD_STR, UVM_LOW)
		end

		//обновление БД очков
		client_points_db[tr.client_id] = exp_tr.client_points; 

		`uvm_info(get_type_name(), `END_TEST_STR, UVM_LOW)
	endfunction: write_USER

endclass
`endif