`ifndef BASE_DRIVER
`define BASE_DRIVER
virtual class base_driver #(
	type INTERFACE_TYPE,
	type TRANSACTION_TYPE
) extends uvm_driver#(TRANSACTION_TYPE);

	`uvm_component_param_utils(base_driver #(INTERFACE_TYPE, TRANSACTION_TYPE))
	
	INTERFACE_TYPE   vif;
	TRANSACTION_TYPE tr;


	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new

	
	pure virtual task reset();
	pure virtual task drive_transaction (TRANSACTION_TYPE tr);
	
	
	virtual task main_phase(uvm_phase phase);

		reset();
		wait (vif.rst_n == 1);
		@(posedge vif.clk);

		fork
			forever begin
				@(negedge vif.rst_n);
				reset();
				@(posedge vif.clk);
			end
			
			forever begin
				if (vif.rst_n == 1) begin
					seq_item_port.get_next_item(tr);
					`uvm_info(get_type_name(), "Start work", UVM_HIGH)
					drive_transaction(tr);
					//`uvm_info(get_type_name(), {"Send transaction ", tr.convert2string()}, UVM_HIGH)
					seq_item_port.item_done();
				end
			end
		join_any
	endtask: main_phase
endclass
`endif