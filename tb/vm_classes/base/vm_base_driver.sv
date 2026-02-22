`ifndef VM_BASE_DRIVER
`define VM_BASE_DRIVER
//==============================================================================
// vm_base_driver — параметризованный базовый класс драйвера UVM для проекта vending_machine.
//
// Назначение:
//   • Наследуется от base_driver и адаптирует его для текущей среды тестирования,
//     предоставляя реализацию ожиданий сигналов сброса на основе clk и rst_n из интерфейса.
//   • Поддерживает специальное поведение для reset_driver: он не ждет deassert rst_n,
//     чтобы избежать блокировки при генерации сброса.
//
// Наследование:
//   1. vm_base_driver <- base_driver: предоставляет базовую инфраструктуру с реализацией
//      ожиданий сброса для vending_machine.
//   2. Конкретные драйверы: admin_driver, emergency_driver, register_driver,
//      user_driver, reset_driver <- vm_base_driver.
//      Наследники должны реализовать только две чистые виртуальные задачи:
//          pure virtual task reset();
//          pure virtual task drive_transaction(TRANSACTION_TYPE tr);
//      Производные классы фокусируются на логике сброса интерфейса и преобразовании
//      транзакций в сигналы. Они не должны переопределять _wait_for_reset_* задачи.
//==============================================================================
virtual class vm_base_driver #(
    type INTERFACE_TYPE,
	type TRANSACTION_TYPE
) extends base_driver #(INTERFACE_TYPE, TRANSACTION_TYPE);

	`uvm_component_param_utils(vm_base_driver #(INTERFACE_TYPE, TRANSACTION_TYPE))

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new



    //======================== Методы обработки интерфейса ======================
    
    pure virtual task drive_transaction (TRANSACTION_TYPE tr);
    pure virtual task reset(); 

    task _reset_();
        reset();
    endtask: _reset_

    task _drive_transaction_ (TRANSACTION_TYPE tr);
        drive_transaction(tr);
    endtask: _drive_transaction_



    //========================== Вспомогательные методы =========================
    
    protected virtual task _wait_for_reset_deassert_();
        // Все драйверы, кроме reset_driver ждут снятия rst_n
        if(get_type_name() != "reset_driver")
		    @(posedge vif.clk iff vif.rst_n == 1);
	endtask: _wait_for_reset_deassert_

    protected virtual task _wait_for_reset_assert_();
		@(negedge vif.rst_n);
	endtask: _wait_for_reset_assert_

endclass
`endif