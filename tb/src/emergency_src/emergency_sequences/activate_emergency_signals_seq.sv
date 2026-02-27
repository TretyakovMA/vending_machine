`ifndef ACTIVATE_EMERGENCY_SIGNALS_SEQ
`define ACTIVATE_EMERGENCY_SIGNALS_SEQ
class activate_emergency_signals_seq extends uvm_sequence #(emergency_transaction);
	`uvm_object_utils(activate_emergency_signals_seq)

	emergency_transaction tr;
	event emergency_event;
	
    
	function new(string name = "activate_emergency_signals_seq");
		super.new(name);
	endfunction
    
	task body();

		if (!uvm_config_db #(event)::get(null, "", "emergency_event", emergency_event))
            `uvm_fatal(get_type_name(), "Failed to get emergency_event from config_db")
		
		tr = emergency_transaction::type_id::create("tr");
		start_item(tr);
		assert (tr.randomize());
		
		fork
			begin
				#(tr.time_delay);
				-> emergency_event;
				uvm_config_db #(bit)::set(null, "*", "emergency_flag", 1);
				`uvm_info(get_type_name(), "Emergency event done", UVM_HIGH)
			end
		join_none

		finish_item(tr);
		
	endtask
endclass
`endif