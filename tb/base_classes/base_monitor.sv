`ifndef BASE_MONITOR
`define BASE_MONITOR
virtual class base_monitor #(
    type INTERFACE_TYPE,
	type TRANSACTION_TYPE
) extends uvm_monitor;

	`uvm_component_param_utils(base_monitor #(INTERFACE_TYPE, TRANSACTION_TYPE))

	INTERFACE_TYPE   vif;
    TRANSACTION_TYPE transaction;

    uvm_analysis_port #(TRANSACTION_TYPE) ap;
	
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new



	//Основные задачи монитора
	pure virtual function bit should_start_monitoring (); 
    pure virtual task collect_transaction_data (TRANSACTION_TYPE tr); 

	

	//Вспомогательные функции (меняются в других проектах)
	protected virtual task wait_for_active_clock(); 
		@(posedge vif.clk iff vif.rst_n == 1);
	endtask: wait_for_active_clock

	protected virtual task wait_for_reset_assert(); 
		@(negedge vif.rst_n);
	endtask: wait_for_reset_assert



	//Бесконечный поиск сигнала сброса
	local task monitor_reset(); 
		forever begin
			wait_for_reset_assert();
			`uvm_info(get_type_name(), "Reset detected", UVM_HIGH)
			disable monitor_transaction; //остановка процесса мониторинга
			transaction = TRANSACTION_TYPE::type_id::create("tr");
			transaction.has_reset = 1; //создается транзакция с сигналом
			ap.write(transaction);     //сброса и отправляется в scoreboard

			fork
            	monitor_transaction(); //перезапуск процесса мониторинга
			join_none
		end
	endtask: monitor_reset

	//Основная задача мониторинга
	local task monitor_transaction(); 
		forever begin
			wait_for_active_clock();

			if (should_start_monitoring()) begin
				transaction = TRANSACTION_TYPE::type_id::create("tr");
				`uvm_info(get_type_name(), "Start work", UVM_HIGH)

				collect_transaction_data(transaction); //сбор данных транзакции

				`uvm_info(get_type_name(), `GET_TR_STR(transaction), UVM_LOW)
				ap.write(transaction); //отправка транзакции на анализ
				`uvm_info(get_type_name(), "End work", UVM_HIGH)
			end
		end
	endtask: monitor_transaction


	//Фазы UVM
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		ap = new("ap", this);
	endfunction: build_phase    

	virtual task main_phase(uvm_phase phase);
		super.main_phase(phase);
		fork
			monitor_reset();
			monitor_transaction();
		join
	endtask: main_phase
	
endclass
`endif