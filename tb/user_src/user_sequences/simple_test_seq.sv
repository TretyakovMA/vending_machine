`ifndef SIMPLE_TEST_SEQ
`define SIMPLE_TEST_SEQ
class simple_test_seq extends user_base_seq;
	`uvm_object_utils(simple_test_seq)
    
	function new(string name = "simple_test_seq");
		super.new(name);
	endfunction

	virtual function void apply_constraints(user_transaction tr);
		tr.client_id       = 3;
		tr.coin_in_q       = {25, 10};
		tr.currency_type_q = {RUB, RUB};
		tr.item_num        = 1;
    endfunction: apply_constraints

endclass
`endif