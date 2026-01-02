`include "user_transaction.sv"
`include "user_coverage.sv"
`include "user_scoreboard.sv"
uvm_event end_work_dut;
typedef uvm_sequencer #(user_transaction) user_sequencer;
`include "user_driver.sv"
`include "user_monitor.sv"
`include "user_agent.sv"