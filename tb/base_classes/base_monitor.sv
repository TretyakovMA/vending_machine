`ifndef BASE_MONITOR
`define BASE_MONITOR
virtual class base_monitor #(
    type INTERFACE_TYPE,
	type TRANSACTION_TYPE
) extends uvm_monitor;

	`uvm_component_param_utils(base_monitor #(INTERFACE_TYPE, TRANSACTION_TYPE))
	
	uvm_analysis_port #(TRANSACTION_TYPE) ap;
	
	INTERFACE_TYPE   vif;
    TRANSACTION_TYPE tr;
	
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new
	
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		ap = new("ap", this);
	endfunction: build_phase
	
	pure virtual task reset();
	pure virtual function bit condition ();
    pure virtual task monitoring_transaction (TRANSACTION_TYPE tr);
    
	
	task reset_phase(uvm_phase phase);
		super.reset_phase(phase);
		reset();
	endtask: reset_phase

	task main_phase(uvm_phase phase);
		super.main_phase(phase);
		fork
			forever begin
				@(negedge vif.rst_n);
				reset();
				@(posedge vif.clk iff vif.rst_n == 1);
			end

			forever begin
				@(posedge vif.clk);
				if (vif.rst_n && condition()) begin
					tr = TRANSACTION_TYPE::type_id::create("tr");
					monitoring_transaction(tr);
					ap.write(tr);
					//`uvm_info(get_type_name(), {"Get transaction: ", tr.convert2string()}, UVM_HIGH)
				end
			end
		join_any
	endtask: main_phase
	
endclass
`endif