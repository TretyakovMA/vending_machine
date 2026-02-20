`ifndef BASE_DRIVER
`define BASE_DRIVER
virtual class base_driver #(
	type INTERFACE_TYPE,
	type TRANSACTION_TYPE
) extends uvm_driver #(TRANSACTION_TYPE);

	`uvm_component_param_utils(base_driver #(INTERFACE_TYPE, TRANSACTION_TYPE))
	
	INTERFACE_TYPE   vif; // Интерфейс будет получен в агенте
	TRANSACTION_TYPE transaction;

	// Флаг, определяющий, нужно ли драйверу реагировать на сброс
	// настраивается агентом
	bit termination_after_reset = 1;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new

	

	//========================= Основные задачи драйвера =======================
	pure virtual task reset();
	pure virtual task drive_transaction (TRANSACTION_TYPE tr);
	


	//========================= Вспомогательные функции ========================

	// Задача для ожидания, пока не опустится сигнала сброса
	protected virtual task wait_for_reset_deassert();
		@(posedge vif.clk iff vif.rst_n == 1);
	endtask: wait_for_reset_deassert

	// Задача для ожидания сигнала сброса
	protected virtual task wait_for_reset_assert();
		@(negedge vif.rst_n);
	endtask: wait_for_reset_assert

	// Функция, определяющая, нужно ли драйверу начинать работу
	protected virtual function bit should_start_driving();
		return (vif.rst_n == 1);
	endfunction: should_start_driving



	//======================== Основная функциональность ========================

	// Бесконечный поиск сигнала сброса
	local task monitor_reset_process(); 
		forever begin
			// Ожидание сигнала сброса
			wait_for_reset_assert();       
			`uvm_info(get_type_name(), "Reset detected", UVM_HIGH)

			// Остановка процесса драйвера
			disable drive_process;

			// Сброс         
			reset();

			// Завершение текущей транзакции
			if(transaction != null) begin
				seq_item_port.item_done();  
				transaction = null; 
			end

			// Ожидание, пока сигнал сброса не опустится
			wait_for_reset_deassert();

			// Перезапуск процесса
			fork
                drive_process(); 
			join_none
		end
	endtask: monitor_reset_process

	// Основная задача в main_phase
	local task drive_process();

		// Ожидание, пока сигнал сброса не опустится
		wait_for_reset_deassert();

		// Начало бесконечной работы
		forever begin
			if (should_start_driving()) begin
				`uvm_info(get_type_name(), "Start work", UVM_HIGH)
				seq_item_port.get_next_item(transaction);

				// Запись транзакции в интерфейс
                drive_transaction(transaction); 
                
                `uvm_info(get_type_name(), "End work", UVM_HIGH)

                seq_item_port.item_done();
			end
		end
	endtask: drive_process
	


	//=========================== Фазы UVM ================================
	virtual task reset_phase(uvm_phase phase);
		super.reset_phase(phase);
		reset();
	endtask: reset_phase
	
	virtual task main_phase(uvm_phase phase);
		super.main_phase(phase);

		// Если установлен termination_after_reset, то драйвер реагирует на сброс
		if (termination_after_reset) fork
			drive_process(); //Параллельно идут процессы основной работы драйвера
			monitor_reset_process(); //и поиска сигнала сброса
		join_any

		// Если termination_after_reset = 0, то драйвер игнорирует сброс
		else begin
			drive_process(); 
		end
	endtask: main_phase

endclass
`endif