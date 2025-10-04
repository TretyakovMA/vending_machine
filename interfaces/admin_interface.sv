`ifndef ADMIN_INTERFACE 
`define ADMIN_INTERFACE
interface admin_interface(input logic clk, logic rst_n);
	
	logic admin_mode;
	logic [31:0] admin_password;

endinterface
`endif