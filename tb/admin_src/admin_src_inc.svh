`include "admin_transaction.sv"

`ifndef ADMIN_SEQUENCER
`define ADMIN_SEQUENCER
typedef uvm_sequencer #(admin_transaction) admin_sequencer;
`endif

`include "admin_driver.sv"
`include "admin_agent.sv"
`include "admin_mode_on_seq.sv"
`include "admin_mode_off_seq.sv"
