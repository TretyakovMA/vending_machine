`ifndef BASE_DRIVER
`define BASE_DRIVER
virtual class base_driver #(
	type INTERFACE_TYPE,
	type TRANSACTION_TYPE
) extends uvm_driver#(TRANSACTION_TYPE);

	`uvm_component_param_utils(base_driver #(INTERFACE_TYPE, TRANSACTION_TYPE))
	
	INTERFACE_TYPE   vif;
	TRANSACTION_TYPE transaction;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new

	

	//Основные задачи драйвера
	pure virtual task reset();
	pure virtual task drive_transaction (TRANSACTION_TYPE tr);
	


	//Вспомогательные функции (меняются в других проектах)
	protected virtual task wait_for_active_clock();
		@(posedge vif.clk iff vif.rst_n == 1);
	endtask: wait_for_active_clock

	protected virtual task wait_for_reset_assert();
		@(negedge vif.rst_n);
	endtask: wait_for_reset_assert

	protected virtual function bit should_start_driving();
		return (vif.rst_n == 1);
	endfunction: should_start_driving



	//Бесконечный поиск сигнала сброса
	local task monitor_reset(); 
		forever begin
			wait_for_reset_assert(); //ожидание сигнала сброса
			`uvm_info(get_type_name(), "Reset detected", UVM_HIGH)
			disable drive_process;   //остановка процесса драйвинга
			reset();

			if(transaction != null) begin
				seq_item_port.item_done(); //завершение текущей 
				transaction = null;        //транзакции
			end

			fork
                drive_process(); //перезапуск процесса драйвинга
			join_none
		end
	endtask: monitor_reset

	//Основная задача в main_phase
	local task drive_process();
		forever begin
			//wait_for_active_clock();
			if (should_start_driving()) begin
				seq_item_port.get_next_item(transaction);
                `uvm_info(get_type_name(), "Start work", UVM_HIGH)

                drive_transaction(transaction); //запись транзакции в интерфейс
                
                `uvm_info(get_type_name(), "End work", UVM_HIGH)
				reset();
				wait_for_active_clock();
                seq_item_port.item_done();
			end
		end
	endtask: drive_process
	


	//Фазы UVM
	task reset_phase(uvm_phase phase);
		super.reset_phase(phase);
		reset();
	endtask: reset_phase
	
	task main_phase(uvm_phase phase);
		super.main_phase(phase);
		wait_for_active_clock();
		fork
			monitor_reset();
			drive_process();
		join_any
	endtask: main_phase

endclass
`endif