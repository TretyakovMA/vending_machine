`ifndef VM_BASE_MONITOR
`define VM_BASE_MONITOR
//==============================================================================
// vm_base_monitor — параметризованный базовый класс монитора UVM для проекта vending_machine.
//
// Назначение:
//   • Наследуется от base_monitor и адаптирует его для текущей среды тестирования,
//     предоставляя реализацию ожиданий сигналов сброса на основе rst_n из интерфейса.
//   • Поддерживает специальное поведение для reset_monitor: он не ждет deassert rst_n,
//     чтобы избежать блокировки при мониторинге сброса.
//
// Наследование:
//   1. vm_base_monitor <- base_monitor: предоставляет базовую инфраструктуру с реализацией
//      ожиданий сброса для vending_machine.
//   2. Конкретные мониторы: admin_monitor, emergency_monitor, register_monitor,
//      user_monitor, reset_monitor <- vm_base_monitor.
//      Наследники должны реализовать только две чистые виртуальные задачи:
//          pure virtual task collect_transaction_data(TRANSACTION_TYPE tr);
//          pure virtual task wait_for_sampling_event();
//      Производные классы фокусируются на логике сбора данных транзакций и ожидании
//      момента начала мониторинга. Они не должны переопределять _wait_for_reset_* задачи.
//==============================================================================
virtual class vm_base_monitor #(
    type INTERFACE_TYPE,
	type TRANSACTION_TYPE
) extends base_monitor #(INTERFACE_TYPE, TRANSACTION_TYPE); 

	`uvm_component_param_utils(vm_base_monitor #(INTERFACE_TYPE, TRANSACTION_TYPE))

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new



    //======================== Методы обработки интерфейса ======================
    
    pure virtual task collect_transaction_data(TRANSACTION_TYPE tr);
    pure virtual task wait_for_sampling_event(); 

    task _wait_for_sampling_event_(); 
		wait_for_sampling_event(); 
	endtask: _wait_for_sampling_event_

    task _collect_transaction_data_(TRANSACTION_TYPE tr); 
        collect_transaction_data(tr);
    endtask: _collect_transaction_data_



    //========================== Вспомогательные методы =========================
    
    protected virtual task _wait_for_reset_assert_(); 
		@(negedge vif.rst_n);
	endtask: _wait_for_reset_assert_

    protected virtual task _wait_for_reset_deassert_(); 
        // Все мониторы, кроме reset_monitor ждут снятия rst_n
        if(get_type_name() != "reset_monitor")
		    wait (vif.rst_n == 1);
    endtask: _wait_for_reset_deassert_

endclass
`endif