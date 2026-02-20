`ifndef BASE_MONITOR
`define BASE_MONITOR
virtual class base_monitor #(
    type INTERFACE_TYPE,
	type TRANSACTION_TYPE
) extends uvm_monitor;

	`uvm_component_param_utils(base_monitor #(INTERFACE_TYPE, TRANSACTION_TYPE))

	INTERFACE_TYPE   vif;
    TRANSACTION_TYPE transaction;

	// Флаг, определяющий, нужно ли монитору реагировать на сброс
	// настраивается агентом
	bit termination_after_reset = 1;

    uvm_analysis_port #(TRANSACTION_TYPE) ap;
	
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new



	// Основные задачи монитора
	pure virtual function bit should_start_monitoring (); 
    pure virtual task collect_transaction_data (TRANSACTION_TYPE tr); 

	

	// Вспомогательные функции (меняются в других проектах)
	protected virtual task wait_for_sampling_event(); 
		@(posedge vif.clk iff vif.rst_n == 1);
	endtask: wait_for_sampling_event

	protected virtual task wait_for_reset_assert(); 
		@(negedge vif.rst_n);
	endtask: wait_for_reset_assert



	// Бесконечный поиск сигнала сброса
	local task monitor_reset(); 
		forever begin
			wait_for_reset_assert();
			`uvm_info(get_type_name(), "Reset detected", UVM_HIGH)
			// Остановка процесса мониторинга
			disable monitor_transaction; 
			
			// Перезапуск процесса мониторинга
			fork
            	monitor_transaction(); 
			join_none
		end
	endtask: monitor_reset

	// Основная задача мониторинга
	local task monitor_transaction(); 
		forever begin
			wait_for_sampling_event();

			if (should_start_monitoring()) begin
				transaction = TRANSACTION_TYPE::type_id::create("tr");
				`uvm_info(get_type_name(), "Start work", UVM_HIGH)

				// Сбор данных транзакции
				collect_transaction_data(transaction); 

				`uvm_info(get_type_name(), `GET_TR_STR(transaction), UVM_LOW)
				// Отправка транзакции на анализ
				ap.write(transaction); 
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

		// Если установлен termination_after_reset, то монитор реагирует на сброс
		if(termination_after_reset) fork
			monitor_reset();
			monitor_transaction();
		join
		
		// Если termination_after_reset = 0, то монитор игнорирует сброс
		else begin
			monitor_transaction();
		end
	endtask: main_phase
	
endclass
`endif