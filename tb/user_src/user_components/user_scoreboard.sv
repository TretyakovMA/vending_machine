`ifndef USER_SCOREBOARD
`define USER_SCOREBOARD
class user_scoreboard extends uvm_scoreboard;
	`uvm_component_utils(user_scoreboard)

	uvm_analysis_imp #(user_transaction, user_scoreboard) a_imp;

	local user_transaction   tr;
	local user_transaction   exp_tr;
	local int                client_points_db[int]; //БД накопленных очков клиентов

	local user_checker             checker_h;


	
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new
	
	//Фазы UVM
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		a_imp = new("a_imp", this);
	endfunction: build_phase

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		if(!uvm_config_db #(user_checker)::get(this, "", "user_checker", checker_h))
			`uvm_fatal(get_type_name(), "Faild to get user_checker_h")
	endfunction: connect_phase

	task reset_phase(uvm_phase phase);
		super.reset_phase(phase);
		reset_points();
	endtask: reset_phase

	

	//Функция сброса БД очков клиентов
	local function void reset_points(); 
		for (int i = 0; i < `MAX_CLIENTS; i++) begin
			client_points_db[i] = i % 20;
		end
	endfunction: reset_points
	
	
	
	//при получении ответа от монитора вызывается эта функция
	function void write (user_transaction t);
		if(t.has_reset) begin
			`uvm_info(get_type_name(), "Reset detected", UVM_HIGH)
			reset_points(); //если приходит транзакция с флагом rst,
			return;         //сбрасываем очки и не продолжаем обработку
		end

		tr     = t.clone_me();
		//Расчет ожидаемой транзакции
		exp_tr = checker_h.calculate_exp_transaction(tr, client_points_db[tr.client_id]);

		`uvm_info(get_type_name(), `EXP_TR_STR(exp_tr), UVM_LOW)

		if (tr.item_out == 0) //Если из DUT не пришел товар, то симуляция завершается
			`uvm_fatal(get_type_name(), "No response from DUT")
		
		if(exp_tr.compare(tr)) begin //Сравнение транзакций
			`uvm_info(get_type_name(), `RES_SUC_STR, UVM_LOW)
		end
		else begin
			`uvm_info(get_type_name(), `RES_FAILD_STR, UVM_LOW)
		end

		client_points_db[tr.client_id] = exp_tr.client_points; //обновление БД очков

		`uvm_info(get_type_name(), `END_TEST_STR, UVM_LOW)
	endfunction: write

endclass
`endif