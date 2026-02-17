`ifndef USER_INTERFACE 
`define USER_INTERFACE
interface user_interface(input logic clk, logic rst_n);
	
	logic                  id_valid;
	logic [8:0]            client_id;
	logic [5:0]            coin_in;
	logic [1:0]            currency_type;
	logic                  coin_insert;
	logic [`NUM_ITEMS-1:0] item_select;
	logic                  confirm;
	
	logic [`NUM_ITEMS-1:0] item_out;
	logic [31:0]           change_out;
	logic                  no_change;
	logic [7:0]            client_points;

	logic [`NUM_ITEMS-1:0] item_empty;

endinterface
`endif