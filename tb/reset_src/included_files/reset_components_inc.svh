`include "../reset_components/reset_transaction.sv"


typedef uvm_sequencer #(reset_transaction) reset_sequencer;


`include "../reset_components/reset_driver.sv"
`include "../reset_components/reset_monitor.sv"
`include "../reset_components/reset_agent.sv"