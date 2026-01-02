`ifndef USER_BASE_SEQ
`define USER_BASE_SEQ
class user_base_seq #(
    int NUMBER_OF_TESTS    = 1,
    int NUMBER_OF_ATTEMPTS = 1000
) extends uvm_sequence #(user_transaction);

    `uvm_object_param_utils(user_base_seq #(NUMBER_OF_TESTS, NUMBER_OF_ATTEMPTS))

    user_scoreboard  scoreboard_h;
	user_transaction tr;
	user_transaction exp_tr;
	uvm_component    component_h;
	bit              success;
	int              count_test;

    function new(string name = "user_base_seq");
        super.new(name);
    endfunction

    // Virtual function for derived classes to override with specific constraints
    virtual function void apply_constraints(user_transaction tr);
        assert(tr.randomize());
    endfunction: apply_constraints

    // Virtual function to check success condition
    virtual function bit check_success(user_transaction exp_tr);
        return exp_tr.change_out[31] == 0;
    endfunction: check_success


    task body();
		component_h = uvm_top.find("*env_h.user_scoreboard_h");
            if(component_h == null)
                `uvm_fatal (get_type_name(), "Failed to get scoreboard")
            if(!$cast(scoreboard_h, component_h))
                `uvm_fatal (get_type_name(), "Failed to cast scoreboard_h")
		
		repeat(NUMBER_OF_TESTS) begin
			tr         = user_transaction::type_id::create("tr");
			count_test = 0;
            success    = 0;

			start_item(tr);

			do begin
				count_test++;
				apply_constraints(tr);

				exp_tr = scoreboard_h.calculate_exp_transaction(tr);

				success = check_success(exp_tr);
				`uvm_info("TEST", {"\n\n\nAttempt to send a transaction: ", exp_tr.convert2string(), "\n\n\n"}, UVM_FULL)
			end while (success == 0 && count_test < NUMBER_OF_ATTEMPTS);

            if (count_test == NUMBER_OF_ATTEMPTS)
                `uvm_fatal(get_type_name(), $sformatf("Failed to generate a valid transaction after %0d attempts", count_test))
            
            `uvm_info(get_type_name(), `MUVC_START_TEST_STR, UVM_LOW)
           
			finish_item(tr);
		end
    endtask

    
endclass
`endif