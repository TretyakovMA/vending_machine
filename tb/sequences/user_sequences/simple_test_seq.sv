`ifndef SIMPLE_TEST_SEQ
`define SIMPLE_TEST_SEQ
class simple_test_seq extends user_base_seq;
	`uvm_object_utils(simple_test_seq)
    
	function new(string name = "simple_test_seq");
		super.new(name);
	endfunction

	function void apply_constraints(user_transaction tr);
		assert(tr.randomize() with{
			coin_in_q.size()   == 95;
		});
    endfunction: apply_constraints

endclass
`endif