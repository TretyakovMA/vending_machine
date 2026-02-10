`include "../error_components/error_transaction.sv"
`include "../error_components/error_driver.sv"
typedef uvm_sequencer #(error_transaction) error_sequencer;
`include "../error_components/error_monitor.sv"
`include "../error_components/error_scoreboard.sv"
`include "../error_components/error_agent.sv"