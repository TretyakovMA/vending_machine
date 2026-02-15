`ifndef USER_BASE_SEQ
`define USER_BASE_SEQ
class user_base_seq #(
    int NUMBER_OF_TESTS    = 1,
    int NUMBER_OF_ATTEMPTS = 1000
) extends uvm_sequence #(user_transaction);

    `uvm_object_param_utils(user_base_seq #(NUMBER_OF_TESTS, NUMBER_OF_ATTEMPTS))

    local user_checker     checker_h;
	local user_transaction tr;
	local user_transaction exp_tr;

	local bit              success;
	local int              count_test;

    function new(string name = "user_base_seq");
        super.new(name);
    endfunction

    // Функция для установки ограничений в производных классах
    protected virtual function void apply_constraints(user_transaction tr);
        assert(tr.randomize());
    endfunction: apply_constraints

    // Функция проверки корректности транзакции
    protected virtual function bit check_success(user_transaction exp_tr);
        return exp_tr.change_out[31] == 0; // Если первый бит 0, то число неотрицательно
    endfunction: check_success


    task body();
        // Поиск checker в иерархии UVM
        if (!uvm_config_db #(user_checker)::get(m_sequencer, "", "user_checker", checker_h))
            `uvm_fatal(get_type_name(), "Failed to get user_checker from sequencer")
        
		
		repeat(NUMBER_OF_TESTS) begin //Тело повторится NUMBER_OF_TESTS раз
			tr         = user_transaction::type_id::create("tr");
			count_test = 0;
            success    = 0;

			start_item(tr);

			do begin
				count_test++;
				apply_constraints(tr); //Первичная рандомизация

				exp_tr  = checker_h.calculate_exp_transaction(tr); //Расчет ожидаемой транзакции

				success = check_success(exp_tr); //Проверка корректности транзакции
				`uvm_info("TEST", {"Attempt to send a transaction: ", exp_tr.convert2string()}, UVM_FULL)
			end while (success == 0 && count_test < NUMBER_OF_ATTEMPTS);

            if (count_test == NUMBER_OF_ATTEMPTS) //Если транзакция не была сгенерирована, то возникает фатальная ошибка
                `uvm_fatal(get_type_name(), $sformatf("Failed to generate a valid transaction after %0d attempts", count_test))
            
            // Если все нормально, то стартуем
            `uvm_info(get_type_name(), `START_TEST_STR, UVM_LOW)
           
			finish_item(tr);
		end
    endtask

    
endclass
`endif