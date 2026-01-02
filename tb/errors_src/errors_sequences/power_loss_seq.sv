`ifndef POWER_LOSS_SEQ
`define POWER_LOSS_SEQ
class power_loss_seq extends uvm_sequence #(errors_transaction);
	`uvm_object_utils(power_loss_seq)

	errors_transaction tr;
    
	function new(string name = "power_loss_seq");
		super.new(name);
	endfunction
    
	task body();
		tr = errors_transaction::type_id::create("tr");
		start_item(tr);
			
		tr.power_loss  = 1;
        tr.tamper_detect  = 1;
        tr.jam_detect  = 1;
		tr.time_delay  = 200ns;
			
		finish_item(tr);
	endtask
endclass
`endif