`ifndef REGISTER_COMPONENT_INC
`define REGISTER_COMPONENT_INC

    `include "../register_components/register_transaction.sv"
    typedef uvm_sequencer     #(register_transaction) register_sequencer;
    typedef uvm_reg_predictor #(register_transaction) register_predictor;
    `include "../register_components/register_driver.sv"
    `include "../register_components/register_monitor.sv"
    `include "../register_components/register_scoreboard.sv"
    `include "../register_components/register_adapter.sv"
    `include "../register_components/register_agent.sv"
    `include "../register_components/register_env.sv"

`endif