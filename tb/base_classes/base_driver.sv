`ifndef BASE_DRIVER
`define BASE_DRIVER
class base_driver #(
	type INTERFACE_TYPE,
	type TRANSACTION_TYPE
) extends uvm_driver#(TRANSACTION_TYPE);

	`uvm_component_param_utils(base_driver #(INTERFACE_TYPE, TRANSACTION_TYPE))
	
	INTERFACE_TYPE   vif;
	TRANSACTION_TYPE tr;


	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new

	
	virtual task reset();
		`uvm_fatal(get_type_name(), "Reset task is not implemented in the base_driver class.")
	endtask: reset

	virtual task drive_transaction (TRANSACTION_TYPE tr);
		`uvm_fatal(get_type_name(), "drive_transaction task is not implemented in the base_driver class.")
	endtask: drive_transaction



	virtual task wait_for_active_clock();
		@(posedge vif.clk iff vif.rst_n == 1);
	endtask

	virtual task wait_for_reset_assert();
		@(negedge vif.rst_n);
	endtask
	

	virtual function bit condition_getting_start();
		return (vif.rst_n == 1);
	endfunction




	
	virtual task reset_phase(uvm_phase phase);
		super.reset_phase(phase);
		reset();
	endtask: reset_phase
	
	virtual task main_phase(uvm_phase phase);
		super.main_phase(phase);
		wait_for_active_clock();
		fork
			forever begin
				wait_for_reset_assert();
				`uvm_info(get_type_name(), "Reset detected", UVM_HIGH)
				reset();
				`uvm_info(get_type_name(), "Wait start work", UVM_HIGH)
				wait_for_active_clock();
			end
			
			forever begin
				if (condition_getting_start()) begin
					seq_item_port.get_next_item(tr);
					`uvm_info(get_type_name(), "Start work", UVM_HIGH)
					drive_transaction(tr);
					`uvm_info(get_type_name(), "End work", UVM_HIGH)
					seq_item_port.item_done();
				end
			end
		join_any
	endtask: main_phase
endclass
`endif