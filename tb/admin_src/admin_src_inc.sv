`include "admin_transaction.sv"
typedef uvm_sequencer #(admin_transaction) admin_sequencer;
`include "admin_driver.sv"
`include "admin_agent.sv"
`include "admin_mode_on_seq.sv"
`include "admin_mode_off_seq.sv"