`ifndef ACTIVATE_ERROR_SIGNALS_SEQ
`define ACTIVATE_ERROR_SIGNALS_SEQ
class activate_error_signals_seq extends uvm_sequence #(error_transaction);
	`uvm_object_utils(activate_error_signals_seq)

	error_transaction tr;
    
	function new(string name = "activate_error_signals_seq");
		super.new(name);
	endfunction
    
	task body();
		tr = error_transaction::type_id::create("tr");
		start_item(tr);
		assert (tr.randomize());
		finish_item(tr);
	endtask
endclass
`endif