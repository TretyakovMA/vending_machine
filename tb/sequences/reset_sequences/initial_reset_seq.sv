`ifndef INITIAL_RESET_SEQ
`define INITIAL_RESET_SEQ
class initial_reset_seq extends uvm_sequence #(reset_transaction);
	`uvm_object_utils(initial_reset_seq)

	reset_transaction tr;
    
	function new(string name = "initial_reset_seq");
		super.new(name);
	endfunction
    
	task body();
		tr = reset_transaction::type_id::create("tr");
        start_item(tr);
        assert(tr.randomize() with {
            time_delay == 0;
            duration   == 10;
        });
        finish_item(tr);
    endtask: body
endclass
`endif