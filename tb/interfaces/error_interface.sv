`ifndef ERROR_INTERFACE 
`define ERROR_INTERFACE
interface error_interface(input logic clk, logic rst_n);

	logic tamper_detect;
	logic jam_detect;
	logic power_loss;
	
	logic alarm;


	//Данные сигналы возможно будут перенесены в другой интерфейс
	logic access_error;
	logic [`NUM_ITEMS-1:0] item_empty;
	

endinterface
`endif