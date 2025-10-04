`ifndef USER_COVERAGE
`define USER_COVERAGE
class user_coverage extends uvm_subscriber #(user_transaction);
	`uvm_component_utils(user_coverage);
	
	user_transaction tr;
	
	
	
	covergroup cg_client_id;
		coverpoint tr.client_id {
			bins clients[] = {[0:`MAX_CLIENTS-1]}; 
		}
	endgroup
	
	covergroup cg_coin_in_q;
		coverpoint tr.coin_in_q.size() {
			bins single = {1};
			bins few = {[2:29]};
			bins many = {[30:79]};
			bins lots = {[80:100]};
		}
	endgroup
	
	covergroup cg_item_num;
		coverpoint tr.item_num {
			bins items[] = {[0:`NUM_ITEMS-1]};
		}
	endgroup
	
	covergroup cg_coin_nominal with function sample (bit [5:0] nominal);
		coverpoint nominal {
			bins noms[] = {1,5,10,25,50};
		}
	endgroup
	
	covergroup cg_currency_type with function sample (currency_type_t c_type);
		coverpoint c_type;
	endgroup
	
	
	
	
	covergroup cg_no_change;
		coverpoint tr.no_change;
	endgroup
	
	covergroup cg_change_out;
		coverpoint tr.change_out {
			bins little = {[1:100]};
			bins average = {[101:1000]};
			bins many = {[1001:$]};
			ignore_bins zero = {0};
		}
	endgroup
	
	function new(string name, uvm_component parent);
		super.new(name, parent);
		cg_client_id = new();
		cg_coin_in_q = new();
		cg_item_num = new();
		cg_coin_nominal = new();
		cg_currency_type = new();
		cg_no_change = new();
		cg_change_out = new();
	endfunction: new
	
	function void write(user_transaction t);
		tr = t;
		`uvm_info("USER_COVERAGE", "start work", UVM_HIGH)
		cg_client_id.sample();
		cg_coin_in_q.sample();
		cg_item_num.sample();
		
		foreach (tr.coin_in_q[i]) begin
			cg_coin_nominal.sample(tr.coin_in_q[i]);
			cg_currency_type.sample(tr.currency_type_q[i]);
		end
		
		cg_no_change.sample();
		cg_change_out.sample();
	endfunction: write
	
endclass

`endif