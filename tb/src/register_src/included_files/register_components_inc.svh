`include "../register_components/register_transaction.sv"

`ifndef REGISTER_SEQUENCER
`define REGISTER_SEQUENCER
typedef uvm_sequencer     #(register_transaction) register_sequencer;
`endif

`ifndef REGISTER_PREDICTOR
`define REGISTER_PREDICTOR
typedef uvm_reg_predictor #(register_transaction) register_predictor;
`endif  

`include "../register_components/register_driver.sv"
`include "../register_components/register_monitor.sv"
`include "../register_components/register_adapter.sv"
`include "../register_components/register_agent.sv"
`include "../register_components/register_env.sv"
