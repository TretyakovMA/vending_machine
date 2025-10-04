`ifndef ADMIN_AGENT
`define ADMIN_AGENT
class admin_agent extends uvm_agent;
	`uvm_component_utils(admin_agent);
	
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction
	
	agent_config #(virtual admin_interface) config_h;

	admin_driver       driver_h;
	admin_sequencer    sequencer_h;
	
	
	
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(agent_config #(virtual admin_interface))::get(this, "", "agent_config", config_h))
			`uvm_fatal("ADMIN_AGENT", "Faild to get config")
	
		
		sequencer_h = admin_sequencer::type_id::create("sequencer_h", this);
		driver_h = admin_driver::type_id::create("driver_h", this);
		
		
	endfunction
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		driver_h.seq_item_port.connect(sequencer_h.seq_item_export);
		driver_h.vif = config_h.vif;
	endfunction 
endclass
`endif
