`include "../admin_components/admin_transaction.sv"

`ifndef ADMIN_SEQUENCER
`define ADMIN_SEQUENCER
typedef uvm_sequencer #(admin_transaction) admin_sequencer;
`endif

`include "../admin_components/admin_driver.sv"
`include "../admin_components/admin_agent.sv"