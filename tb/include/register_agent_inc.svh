`include "../agents/register_agent/register_transaction.sv"

typedef uvm_sequencer     #(register_transaction) register_sequencer;

typedef uvm_reg_predictor #(register_transaction) register_predictor; 

`include "../agents/register_agent/register_driver.sv"
`include "../agents/register_agent/register_monitor.sv"
`include "../agents/register_agent/register_adapter.sv"
`include "../agents/register_agent/register_agent.sv"
`include "../agents/register_agent/register_env.sv"

`include "../agents/register_agent/unauthorized_write_monitor.sv"
