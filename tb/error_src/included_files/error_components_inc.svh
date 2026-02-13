`include "../error_components/error_transaction.sv"
`include "../error_components/error_driver.sv"

`ifndef ERROR_SEQUENCER
`define ERROR_SEQUENCER
typedef uvm_sequencer #(error_transaction) error_sequencer;
`endif

`include "../error_components/error_monitor.sv"
`include "../error_components/error_agent.sv"