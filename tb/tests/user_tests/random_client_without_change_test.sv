`ifndef RANDOM_CLIENTS_WITHOUT_CHANGE_TEST
`define RANDOM_CLIENTS_WITHOUT_CHANGE_TEST
class random_client_without_change_test extends user_base_test #(
	random_client_without_change_seq
);
	`uvm_component_utils(random_client_without_change_test)
	
	function new(string name = "random_client_without_change_test", uvm_component parent);
		super.new(name, parent);
	endfunction
	
endclass
`endif