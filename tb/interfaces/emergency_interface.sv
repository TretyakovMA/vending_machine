`ifndef EMERGENCY_INTERFACE 
`define EMERGENCY_INTERFACE
interface emergency_interface(input logic clk, logic rst_n);

	logic tamper_detect;
	logic jam_detect;
	logic power_loss;
	
	logic alarm;
	
endinterface
`endif