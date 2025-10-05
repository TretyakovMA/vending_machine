`ifndef USER_SCOREBOARD
`define USER_SCOREBOARD
class user_scoreboard extends uvm_scoreboard;
	`uvm_component_utils(user_scoreboard)

	uvm_analysis_imp #(user_transaction, user_scoreboard) a_imp;
	user_transaction exp_tr;
	
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		a_imp = new("a_imp", this);
	endfunction: build_phase
	
	
	
	task reset_phase(uvm_phase phase);
		user_transaction::reset_points();
		`uvm_info("SCOREBOARD", "Reset points", UVM_HIGH)
	endtask: reset_phase
	
	
	function void write (user_transaction t);
		exp_tr = t.clone_me();
		exp_tr.calculate_exp_transaction();
		`uvm_info("SCOREBOARD", {s_exp_tr_1, exp_tr.convert2string(), s_exp_tr_2}, UVM_LOW)
		
		if (t.item_out == 0)
			`uvm_fatal("SCOREBOARD", "No response from DUT")
		
		if(exp_tr.compare(t))
			`uvm_info("SCOREBOARD", s_com_successful, UVM_LOW)
		else 
			`uvm_error("SCOREBOARD", s_com_errorr)
		`uvm_info("TEST", s_test_done, UVM_LOW)
	endfunction: write
	
	
	
	
	
	string s_exp_tr_1 = "\n\n\n*********************************   Expected transaction   *********************************\n";
	
	string s_exp_tr_2 = "\n********************************************************************************************\n\n";
	
	string s_com_successful = "\n\n\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!   Result   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\nTest successful\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n\n";
	
	string s_com_errorr = "\n\n\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!   Result   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\nTest faild\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n\n";
	
	string s_test_done = "\n###########################################   End   ##########################################\n\n\n\n\n\n\n\n";
endclass
`endif