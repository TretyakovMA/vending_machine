`ifndef BASE_AGENT
`define BASE_AGENT


`define AGENT_PARAM_DECL #(\
	type INTERFACE_TYPE,\
	type TRANSACTION_TYPE,\
	type DRIVER_TYPE,\
	type SEQUENCER_TYPE,\
	type MONITOR_TYPE\
)

`define AGENT_PARAM_UTILS #(INTERFACE_TYPE, TRANSACTION_TYPE, DRIVER_TYPE, SEQUENCER_TYPE, MONITOR_TYPE)

class base_agent `AGENT_PARAM_DECL extends uvm_agent;
    `uvm_component_param_utils (base_agent `AGENT_PARAM_UTILS)

    function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new

	agent_config #(INTERFACE_TYPE) config_h;

	DRIVER_TYPE       driver_h;
	SEQUENCER_TYPE    sequencer_h;
	MONITOR_TYPE      monitor_h;

	uvm_analysis_port #(TRANSACTION_TYPE) ap;



	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(agent_config #(INTERFACE_TYPE))::get(this, "", "agent_config", config_h))
			`uvm_fatal(get_type_name(), "Faild to get config")
	
		if (config_h.is_active == UVM_ACTIVE) begin
			driver_h    = DRIVER_TYPE::type_id::create("driver_h", this);
			sequencer_h = SEQUENCER_TYPE::type_id::create("sequencer_h", this);
		end 
		
		if (config_h.has_monitor == 1) begin
			monitor_h = register_monitor::type_id::create("monitor_h", this);
			ap = new("ap", this);
		end
		
	endfunction
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		if (config_h.is_active == UVM_ACTIVE) begin
			driver_h.seq_item_port.connect(sequencer_h.seq_item_export);
			driver_h.vif = config_h.vif;
		end
		if (config_h.has_monitor == 1) begin
			monitor_h.ap.connect(ap);
		end
		
	endfunction 

endclass
`endif