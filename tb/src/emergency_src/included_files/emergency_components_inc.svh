`include "../emergency_callbacks/emergency_driver_cb.sv"
`include "../emergency_callbacks/delay_after_alarm_test_cb.sv"

`include "../emergency_components/emergency_transaction.sv"
`include "../emergency_components/emergency_driver.sv"

`ifndef EMERGENCY_SEQUENCER
`define EMERGENCY_SEQUENCER
typedef uvm_sequencer #(emergency_transaction) emergency_sequencer;
`endif

`include "../emergency_components/emergency_monitor.sv"
`include "../emergency_components/emergency_agent.sv"