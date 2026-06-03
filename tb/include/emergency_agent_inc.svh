`include "../agents/emergency_agent/emergency_transaction.sv"
`include "../agents/emergency_agent/emergency_driver.sv"

typedef uvm_sequencer #(emergency_transaction) emergency_sequencer;

`include "../agents/emergency_agent/emergency_monitor.sv"
`include "../agents/emergency_agent/emergency_agent.sv"