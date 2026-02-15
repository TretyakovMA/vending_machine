`ifndef REGISTER_BASE_VIRTUAL_SEQ
`define REGISTER_BASE_VIRTUAL_SEQ
class register_base_virtual_seq #(
    type REG_TEST_SEQ
) extends uvm_sequence #(uvm_sequence_item);

	`uvm_object_param_utils(register_base_virtual_seq #(REG_TEST_SEQ))
    
	function new(string name = "register_base_virtual_seq");
		super.new(name);
	endfunction
    
    admin_mode_on_seq    admin_mode_on_h;
    REG_TEST_SEQ         reg_seq_h;
	admin_mode_off_seq   admin_mode_off_h;

    admin_sequencer      admin_sequencer_h;
    register_sequencer   register_sequencer_h;

    bit [31:0]           admin_password;

	
	task body();
		// Получение секвенсеров
        if (!uvm_config_db #(admin_sequencer)::get(null, "", "admin_sequencer", admin_sequencer_h))
            `uvm_fatal(get_type_name(), "Failed to get admin_sequencer from config_db");
        if (!uvm_config_db #(register_sequencer)::get(null, "", "register_sequencer", register_sequencer_h))
            `uvm_fatal(get_type_name(), "Failed to get register_sequencer from config_db");
        
        // Создание секвенсов
        admin_mode_on_h  = admin_mode_on_seq::type_id::create("admin_mode_on_h");
        reg_seq_h        = REG_TEST_SEQ::type_id::create("reg_seq_h");
		admin_mode_off_h = admin_mode_off_seq::type_id::create("admin_mode_off_h");


        // Получение пароля администратора из регистра и его установка
        reg_seq_h.get_registers();
        admin_password = reg_seq_h.reg_block_h.vend_paswd.get_mirrored_value();
        admin_mode_on_h.admin_password = admin_password;

        // Начало выполнения последовательностей
        admin_mode_on_h.start(admin_sequencer_h);//Сначала происходит переход в режим администратора
        reg_seq_h.start(register_sequencer_h);//Выполняется основная последовательность
		admin_mode_off_h.start(admin_sequencer_h);//В конце происходит выход из режима администратора
	endtask
endclass
`endif