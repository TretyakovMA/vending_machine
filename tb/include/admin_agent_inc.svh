`include "../agents/admin_agent/admin_transaction.sv"

typedef uvm_sequencer #(admin_transaction) admin_sequencer;

`include "../agents/admin_agent/admin_driver.sv"
`include "../agents/admin_agent/admin_monitor.sv"
`include "../agents/admin_agent/admin_agent.sv"