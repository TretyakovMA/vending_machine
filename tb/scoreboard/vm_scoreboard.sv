`ifndef VM_SCOREBOARD
`define VM_SCOREBOARD

class vm_scoreboard extends uvm_scoreboard;
	`uvm_component_utils(vm_scoreboard)

	`uvm_analysis_imp_decl(_RESET)
	`uvm_analysis_imp_decl(_USER)
	`uvm_analysis_imp_decl(_ADMIN)
	`uvm_analysis_imp_decl(_REGISTER)
	`uvm_analysis_imp_decl(_EMERGENCY)


	uvm_analysis_imp_RESET #(reset_transaction, vm_scoreboard) reset_imp;
	uvm_analysis_imp_USER #(user_transaction, vm_scoreboard) user_imp;
	uvm_analysis_imp_ADMIN #(admin_transaction, vm_scoreboard) admin_imp;
	uvm_analysis_imp_REGISTER #(register_transaction, vm_scoreboard) register_imp;
	uvm_analysis_imp_EMERGENCY #(emergency_transaction, vm_scoreboard) emergency_imp;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new

	// Класс для проверки пользовательской транзакции
	user_checker checker_h;

	
	vm_reg_access_cb           reg_cb_h;
	register_transaction       reg_tr_q[$];
	virtual register_interface vif;

	// БД накопленных очков клиентов
	int client_points_db[int]; 

	// Регистровая модель
	vm_reg_block reg_block_h;

	// Флаг наличия сигнала прерывания в время пользовательской сессии
	bit emergency_occurred = 0; 

	// Флаг того, что в тесте используется регистровая модель (устанавливается в env)
	bit has_reg_model; 

	// Флаг, что DUT перешел в режим админа
	bit admin_mode;

	// Флаг, что scoreboard ожидает access_error в следующей register_transaction
	bit expect_access_error_next; // Это не костыль, это нестандартное решение


	// Функция сброса БД очков клиентов
	function void reset_points(); 
		`uvm_info (get_type_name(), "Resetting client points database", UVM_HIGH)
		for (int i = 0; i < `MAX_CLIENTS; i++) begin
			client_points_db[i] = i % 20;
		end
	endfunction: reset_points



	function void update_write_ignore();
		if (reg_cb_h == null) return;

		if (admin_mode == 0 || emergency_occurred == 1) begin
			reg_cb_h.write_should_be_ignored = 1;
			`uvm_info(get_type_name(), 
				$sformatf("write_should_be_ignored set to 1 (admin_mode=%b, emergency=%b)", 
					admin_mode, emergency_occurred), UVM_FULL)
		end
		else begin
			reg_cb_h.write_should_be_ignored = 0;
			`uvm_info(get_type_name(), "write_should_be_ignored set to 0 (admin mode + no emergency)", UVM_FULL)
		end
	endfunction: update_write_ignore


	
	//============================== Фазы UVM ====================================
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		reset_imp     = new("reset_imp", this);
		user_imp      = new("user_imp", this);
		admin_imp     = new("admin_imp", this);
		register_imp  = new("register_imp", this);
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

			if(!uvm_config_db #(vm_reg_access_cb)::get(this, "", "reg_cb", reg_cb_h))
				`uvm_fatal(get_type_name(), "Failed to get reg_cb")

			// Чекер получает регистровую модель
			checker_h.reg_block_h = reg_block_h;
		end

		// Поиск интерфейса
		if(!uvm_config_db #(virtual interface register_interface)::get(
			this, "", "register_vif", vif
		)) `uvm_fatal(get_type_name(), "Faild to get register interface")

	endfunction: connect_phase

	task reset_phase(uvm_phase phase);
		super.reset_phase(phase);
		// Сброс очков и регистровой модели
		reset_points();
		if(has_reg_model) begin
			reg_block_h.reset();
			update_write_ignore();
		end
	endtask: reset_phase
	


	//==========================  Обработка транзакций  ============================= 

	// Реакция на сигнал сброса
	function void write_RESET (reset_transaction t); 
		`uvm_info(get_type_name(), "Reset detected", UVM_HIGH)

		reg_block_h.reset();
		reset_points();
		emergency_occurred       = 0;
		admin_mode               = 0;
		expect_access_error_next = 0;
		update_write_ignore();

		`uvm_info(get_type_name(), `END_TEST_STR, UVM_LOW)
	endfunction: write_RESET


	// Обнаружение перехода в admin_mode
	function void write_ADMIN (admin_transaction t); 

		if (t.admin_mode && t.admin_password == reg_block_h.vend_paswd.get()) begin 
			admin_mode = 1;
			`uvm_info(get_type_name(), "Admin mode detected", UVM_LOW)
		end
		else begin
			admin_mode = 0;
		end

		update_write_ignore();
	endfunction: write_ADMIN


	
	// Обработка регистровых транзакций
	function void write_REGISTER (register_transaction t);
		// Сохранение транзакции для проверки в main_phase
		reg_tr_q.push_back(t);

		// Проверка появления сигнала access_error при попытке записи без admin_mode
    	// 1. Сначала проверяем результат предыдущей записи (access_error пришёл на этом такте)
		if (expect_access_error_next) begin
			if (t.access_error != 1) begin
				`uvm_error(get_type_name(), "Signal access_error is not set to 1")
			end
			else begin
				`uvm_info(get_type_name(), "Signal access_error is correct", UVM_LOW)
			end
			expect_access_error_next = 0;
		end

		// 2. Если сейчас пришла попытка записи — ставим ожидание на следующий такт
		if (t.regs_we == 1) begin
			if (admin_mode == 0) begin
				expect_access_error_next = 1;
				`uvm_info(get_type_name(), "Write attempt detected → expect access_error=1 on next cycle", UVM_FULL)
			end 
			else begin
				expect_access_error_next = 0;
			end
		end
	endfunction: write_REGISTER

	
	function uvm_reg get_reg_by_transaction(
		vm_reg_block         reg_block,
		register_transaction tr
	);
		uvm_reg        reg_handle;
		uvm_reg_addr_t offset;

		if (reg_block == null) begin
			`uvm_error(get_type_name(), "reg_block is null")
			return null;
		end
		if (tr == null) begin
			`uvm_error(get_type_name(), "transaction is null")
			return null;
		end

		// Адрес в транзакции — 8 бит
		offset = tr.regs_addr;

		reg_handle = reg_block.reg_map.get_reg_by_offset(offset);

		if (reg_handle == null) begin
			`uvm_warning(get_type_name(), 
				$sformatf("No register found at address 0x%0h", offset))
		end

		return reg_handle;

	endfunction: get_reg_by_transaction




	// Проверка операций записи в регистры
	task main_phase(uvm_phase phase);
		register_transaction tr;
		uvm_reg 			 register;
		uvm_status_e		 status;

		super.main_phase(phase);
		forever begin 
			wait ((reg_tr_q.size() > 0) && (reg_tr_q[0].regs_we == 1));
			phase.raise_objection(this);

			tr = reg_tr_q.pop_front();
			register = get_reg_by_transaction(reg_block_h, tr);

			@(posedge vif.clk);
			
			register.mirror(status, UVM_CHECK, UVM_BACKDOOR);

			phase.drop_objection(this);
		end
	endtask: main_phase
	



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

		update_write_ignore();
	endfunction: write_EMERGENCY
	



	// Обработка пользовательских транзакций
	function void write_USER (user_transaction t);

		// Текущая и ожидаемая пользовательские транзакции
		user_transaction   tr;
		user_transaction   exp_tr;

		// Переменные для изменения количества товаров после покупки
		int item_count;
		int item_id;

		tr = t.clone_me(); //Работаем с копией транзакции

		//============================ Проверка на ошибки ==================================

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

		// Если сигнала нет, а регистровая модель говорит, что товар закончился, то это ошибка
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

		// Если завершилось время ожидания, то все монеты должны вернуться в виде сдачи
		if(tr.idle_timeout) begin
			int balance = checker_h.calculate_balance(tr.coin_in_q, tr.currency_type_q);
			`uvm_info(get_type_name(), "Idle timeout detected", UVM_LOW)

			if (tr.change_out != balance) begin
				`uvm_error(get_type_name(), $sformatf("Change_out after idle_timeout = %0d; expected = %0d", tr.change_out, balance))
			end

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