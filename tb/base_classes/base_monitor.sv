`ifndef BASE_MONITOR
`define BASE_MONITOR
class base_monitor #(
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
	
	virtual task reset();
		`uvm_fatal(get_type_name(), "Reset task is not implemented in the base_monitor class.")
	endtask: reset

    virtual task monitoring_transaction (TRANSACTION_TYPE tr);
		`uvm_fatal(get_type_name(), "monitoring_transaction task is not implemented in the base_monitor class.")
	endtask: monitoring_transaction


	virtual task wait_start_work();
		@(posedge vif.clk iff vif.rst_n == 1);
	endtask

	virtual task wait_reset();
		@(negedge vif.rst_n);
	endtask

	virtual function bit condition_start_monitoring ();
		return (vif.rst_n == 1);
	endfunction

	virtual function bit condition_write ();
		return (vif.rst_n == 1);
	endfunction
    
	
	task reset_phase(uvm_phase phase);
		super.reset_phase(phase);
		reset();
	endtask: reset_phase

	task main_phase(uvm_phase phase);
		super.main_phase(phase);
		fork
			forever begin
				wait_reset();
				reset();
				wait_start_work();
			end

			forever begin
				wait_start_work();
				if (condition_start_monitoring) begin
					tr = TRANSACTION_TYPE::type_id::create("tr");
					monitoring_transaction(tr);

					if(condition_write()) begin
						`uvm_info(get_type_name(), `MUVC_GET_TR_STR(tr), UVM_MEDIUM)
						ap.write(tr);
					end
				end
			end
		join_any
	endtask: main_phase
	
endclass
`endif