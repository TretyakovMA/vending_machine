`include "../agents/reset_agent/reset_transaction.sv"


typedef uvm_sequencer #(reset_transaction) reset_sequencer;


`include "../agents/reset_agent/reset_driver.sv"
`include "../agents/reset_agent/reset_monitor.sv"
`include "../agents/reset_agent/reset_agent.sv"