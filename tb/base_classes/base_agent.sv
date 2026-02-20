
`ifndef BASE_AGENT
`define BASE_AGENT

virtual class base_agent #(
	type INTERFACE_TYPE,
	type TRANSACTION_TYPE,
	type DRIVER_TYPE    = void_driver   #(INTERFACE_TYPE, TRANSACTION_TYPE),
	type MONITOR_TYPE   = void_monitor  #(INTERFACE_TYPE, TRANSACTION_TYPE),
	type SEQUENCER_TYPE = uvm_sequencer #(TRANSACTION_TYPE)
) extends uvm_agent;

    `uvm_component_param_utils (base_agent #(
		INTERFACE_TYPE, 
		TRANSACTION_TYPE, 
		DRIVER_TYPE, 
		MONITOR_TYPE, 
		SEQUENCER_TYPE
		)
	)

    function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new

	base_agent_config #(INTERFACE_TYPE) config_h;

	DRIVER_TYPE     driver_h;
	SEQUENCER_TYPE  sequencer_h;
	MONITOR_TYPE    monitor_h;

	string          sequencer_name;

	uvm_analysis_port #(TRANSACTION_TYPE) ap;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(base_agent_config #(INTERFACE_TYPE))::get(this, "", "agent_config", config_h))
			`uvm_fatal(get_type_name(), "Faild to get config")
	
		if (config_h.is_active == UVM_ACTIVE) begin
			driver_h       = DRIVER_TYPE::type_id::create("driver_h", this);
			sequencer_h    = SEQUENCER_TYPE::type_id::create("sequencer_h", this);

			sequencer_name = driver_h.get_type_name();
			sequencer_name = {sequencer_name.substr(0, sequencer_name.len()-7), "sequencer"};
			uvm_config_db #(SEQUENCER_TYPE)::set(null, "*", sequencer_name, sequencer_h);
		end 
		
		if (config_h.has_monitor == 1) begin
			monitor_h   = MONITOR_TYPE::type_id::create("monitor_h", this);
			ap          = new("ap", this);
		end
		
	endfunction
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		if (config_h.is_active == UVM_ACTIVE) begin
			driver_h.seq_item_port.connect(sequencer_h.seq_item_export);
			driver_h.vif  = config_h.vif;
			driver_h.termination_after_reset = config_h.termination_after_reset;
		end
		if (config_h.has_monitor == 1) begin
			monitor_h.ap.connect(ap);
			monitor_h.vif = config_h.vif;
			driver_h.termination_after_reset = config_h.termination_after_reset;
		end
		
	endfunction 

endclass
`endif