`ifndef SEQUENCE_BASE_TEST
`define SEQUENCE_BASE_TEST

typedef class base_test;

virtual class sequence_base_test #(
    type   SEQUENCE_TYPE,
    type   SEQUENCER_TYPE      = uvm_sequencer #(uvm_sequence_item),
    bit    IS_VIRTUAL_SEQUENCE = 1,
    type   PARENT_TYPE         = base_test
) extends PARENT_TYPE;

    `uvm_component_param_utils(sequence_base_test #(
        SEQUENCE_TYPE,
        SEQUENCER_TYPE,
        IS_VIRTUAL_SEQUENCE,
        PARENT_TYPE
        )
    );


    SEQUENCE_TYPE     sequence_h;
    SEQUENCER_TYPE    sequencer_h = null;
    


    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new


    // Функция для получения имения секвенсера 
    // (используется для тестов с не виртуальными последовательностями)
    virtual function string get_sequencer_name();
        return "";  
    endfunction: get_sequencer_name


    // Функция для создания callback
	// Настраивается в производных тестах
	virtual function void create_callbacks(); 

	endfunction: create_callbacks

    
    
    virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);

        // Создание callback
		create_callbacks();
        
        // Если последовательность не виртуальная
        if (!IS_VIRTUAL_SEQUENCE) begin
            // Получаем имя секвенсера
            string sequencer_name = get_sequencer_name();
            if (sequencer_name == "") //Проверка, что имя секвенсера указано
                `uvm_fatal(get_type_name(), "Sequencer name not provided via get_sequencer_name()");

            // Поиск секвенсера в uvm_config_db
            if (!uvm_config_db #(SEQUENCER_TYPE)::get(this, "", sequencer_name, sequencer_h))
                `uvm_fatal(get_type_name(), $sformatf("Failed to get sequencer from config_db: field_name=%s", sequencer_name));
        end
    endfunction: connect_phase
    
    virtual task main_phase(uvm_phase phase);
        super.main_phase(phase);

        // Создание и запуск последовательности
        sequence_h = SEQUENCE_TYPE::type_id::create("sequence_h");

        `uvm_info(get_type_name(), "Starting sequence", UVM_HIGH);
        
        sequence_h.set_starting_phase(phase);
        sequence_h.set_automatic_phase_objection(1);
        sequence_h.start(sequencer_h);
    endtask: main_phase

endclass
`endif