`include "../user_components/user_transaction.sv"
`include "../user_components/user_coverage.sv"
`include "../user_components/user_checker.sv"
`include "../user_components/user_scoreboard.sv"

`ifndef USER_SEQUENCER
`define USER_SEQUENCER
typedef uvm_sequencer #(user_transaction) user_sequencer;
`endif

`include "../user_components/user_driver.sv"
`include "../user_components/user_monitor.sv"
`include "../user_components/user_agent.sv"