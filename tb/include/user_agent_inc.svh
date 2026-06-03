`include "../agents/user_agent/user_transaction.sv"

typedef uvm_sequencer #(user_transaction) user_sequencer;

`include "../agents/user_agent/user_driver.sv"
`include "../agents/user_agent/user_monitor.sv"
`include "../agents/user_agent/user_agent.sv"