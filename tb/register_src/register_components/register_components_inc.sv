`include "register_transaction.sv"
typedef uvm_sequencer     #(register_transaction) register_sequencer;
typedef uvm_reg_predictor #(register_transaction) register_predictor;
`include "register_driver.sv"
`include "register_monitor.sv"
`include "register_scoreboard.sv"
`include "register_adapter.sv"
`include "register_agent.sv"
`include "register_env.sv"