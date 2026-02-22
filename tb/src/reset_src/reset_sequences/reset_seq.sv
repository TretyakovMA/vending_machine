`ifndef RESET_SEQ
`define RESET_SEQ
class reset_seq extends uvm_sequence #(reset_transaction);
	`uvm_object_utils(reset_seq)

	reset_transaction tr;
    
	function new(string name = "reset_seq");
		super.new(name);
	endfunction
    
	task body();
		tr = reset_transaction::type_id::create("tr");
        start_item(tr);
        assert(tr.randomize() with {
            time_delay == 40;
            duration   == 10;
        });
        finish_item(tr);
    endtask: body
endclass
`endif