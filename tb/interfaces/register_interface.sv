`ifndef REGISTER_INTERFACE 
`define REGISTER_INTERFACE
interface register_interface(input logic clk, logic rst_n);

	logic [31:0] regs_data_in;
	logic [31:0] regs_data_out;
	logic        regs_we;
	logic [7:0]  regs_addr;

	logic        access_error;
	
endinterface
`endif