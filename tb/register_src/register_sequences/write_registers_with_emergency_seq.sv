`ifndef WRITE_REGISTERS_WITH_EMERGENCY_SEQ
`define WRITE_REGISTERS_WITH_EMERGENCY_SEQ

class write_registers_with_emergency_seq extends register_base_seq;
    `uvm_object_utils(write_registers_with_emergency_seq)

    function new(string name = "write_registers_with_emergency_seq");
		super.new(name);
	endfunction

    event emergency_event;
    bit   emergency_event_occurred  = 0;
    bit   emergency_occurred        = 0;
    bit   emergency_flag;

    uvm_reg_data_t old_value;

    task body();
        super.body();

        // Получение события сигнала сбоя
        if (!uvm_config_db #(event)::get(null, "", "emergency_event", emergency_event))
            `uvm_fatal(get_type_name(), "Failed to get emergency_event from config_db")


        // Проверка, произошло ли событие до начала последовательности
        if (uvm_config_db #(bit)::get(null, "", "emergency_flag", emergency_event_occurred)) begin
            `uvm_info(get_type_name(), "Emergency event already occurred before sequence start", UVM_LOW)
        end 
        else begin
            `uvm_info(get_type_name(), "Emergency event will be simulated", UVM_LOW)
        end

        // Ожидание события (параллельно с записью регистров)
        fork
            begin
                @emergency_event;
                `uvm_info(get_type_name(), "Emergency_event occured", UVM_HIGH)
                emergency_event_occurred = 1;
            end
        join_none

        // Запись регистров 
        foreach(registers[i]) begin
            // Если произошло событие, то поднимается флаг emergency_occurred
            if(emergency_event_occurred && emergency_occurred == 0) begin 
                emergency_occurred  = 1;
                `uvm_info(get_type_name(), $sformatf("Emergency_event in register %s occured", registers[i].get_name()), UVM_LOW)
            end

            // Получение старого значения регистра (если был сигнал сбоя)
            if(emergency_occurred) begin
                registers[i].peek(status, old_value);
                `uvm_info(get_type_name(), $sformatf("Register %s value was %0d", registers[i].get_name(), old_value), UVM_MEDIUM)
            end

            // Запись случайного значения в регистр 
            write_random_value(registers[i]);

            // Если был сигнал сбоя, то регистровая модель предполагает,
            // что значение регистра не изменилось
            if(emergency_occurred) begin
                void '(registers[i].predict(old_value));
            end
        end

        // Проверка записанных регистров
        #1;
        check_registers();
            
        reg_block_h.print();
        	
    endtask: body
endclass
`endif