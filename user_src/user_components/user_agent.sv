`ifndef USER_AGENT
`define USER_AGENT
class user_agent extends uvm_agent;
	`uvm_component_utils(user_agent);
	
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction
	
	agent_config #(virtual user_interface) config_h;

	user_driver       driver_h;
	user_sequencer    sequencer_h;
	user_monitor      monitor_h;
	
	uvm_analysis_port#(user_transaction) ap;
	
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(agent_config #(virtual user_interface))::get(this, "", "agent_config", config_h))
			`uvm_fatal("USER_AGENT", "Faild to get config")
	
		if (config_h.is_active == UVM_ACTIVE) begin
			sequencer_h = user_sequencer::type_id::create("sequencer_h", this);
			driver_h = user_driver::type_id::create("driver_h", this);
		end 
		
		monitor_h = user_monitor::type_id::create("monitor_h", this);
		ap = new("ap", this);
		
	endfunction
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		if (config_h.is_active == UVM_ACTIVE) begin
			driver_h.seq_item_port.connect(sequencer_h.seq_item_export);
			driver_h.vif = config_h.vif;
		end
		monitor_h.ap.connect(ap);
		
	endfunction 
endclass
`endif
