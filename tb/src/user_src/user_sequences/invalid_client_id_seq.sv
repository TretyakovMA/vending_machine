`ifndef INVALID_CLIENT_ID_SEQ
`define INVALID_CLIENT_ID_SEQ

class invalid_client_id_seq extends user_base_seq;
	`uvm_object_utils(invalid_client_id_seq)

	function new(string name = "invalid_client_id_seq");
		super.new(name);
	endfunction

	function void apply_constraints(user_transaction tr);
		tr.valid_client_id.constraint_mode(0);
        assert(tr.randomize() with{
			client_id >= `MAX_CLIENTS;
        });
	endfunction: apply_constraints
endclass
`endif