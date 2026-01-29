`ifndef BASE_MONITOR
`define BASE_MONITOR
virtual class base_monitor #(
    type INTERFACE_TYPE,
	type TRANSACTION_TYPE
) extends uvm_monitor;

	`uvm_component_param_utils(base_monitor #(INTERFACE_TYPE, TRANSACTION_TYPE))

	INTERFACE_TYPE   vif;
    TRANSACTION_TYPE transaction;
	local bit        has_reset = 0; 

    uvm_analysis_port #(TRANSACTION_TYPE) ap;


	
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		ap = new("ap", this);
	endfunction: build_phase



	pure virtual function bit should_start_monitoring (); 
    pure virtual task collect_transaction_data (TRANSACTION_TYPE tr); 

	

	protected virtual task wait_for_active_clock(); //переопределить при изменении сигналов
		@(posedge vif.clk iff vif.rst_n == 1);
	endtask: wait_for_active_clock

	protected virtual task wait_for_reset_assert(); //переопределить при изменении сигналов
		@(negedge vif.rst_n);
	endtask: wait_for_reset_assert



	protected task monitor_reset(); 
		forever begin
			wait_for_reset_assert();
			`uvm_info(get_type_name(), "Reset detected", UVM_HIGH)
			has_reset   = 1;
			transaction = TRANSACTION_TYPE::type_id::create("tr");
			transaction.has_reset = 1;
			ap.write(transaction); 
		end
	endtask: monitor_reset

	protected task monitor_transaction(); 
		forever begin
			wait_for_active_clock();
			has_reset = 0;

			if (should_start_monitoring()) begin
				transaction = TRANSACTION_TYPE::type_id::create("tr");
				collect_transaction_data(transaction); 

				if(!has_reset) begin
					`uvm_info(get_type_name(), `GET_TR_STR(transaction), UVM_MEDIUM)
					ap.write(transaction); 
				end
			end
		end
	endtask: monitor_transaction

    

	task main_phase(uvm_phase phase);
		super.main_phase(phase);
		fork
			monitor_reset();
			monitor_transaction();
		join
	endtask: main_phase
	
endclass
`endif