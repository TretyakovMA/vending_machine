module top;
	timeunit 1ns;
	timeprecision 100ps;
	
	import uvm_pkg::*;
	`include "uvm_macros.svh"
	
	import vm_pkg::*;
	
	
	logic clk;
	logic rst_n;
	
	
	
	user_interface user_if         (clk, rst_n);
	admin_interface admin_if       (clk, rst_n);
	register_interface register_if (clk, rst_n);
	errors_interface errors_if     (clk, rst_n);
	
	vending_machine DUT (
		.clk(clk),
		.rst_n(rst_n),
        
		.id_valid(user_if.id_valid),
		.client_id(user_if.client_id),
		.coin_in(user_if.coin_in),
		.currency_type(user_if.currency_type),
		.coin_insert(user_if.coin_insert),
		.item_select(user_if.item_select),
		.confirm(user_if.confirm),

		.admin_mode(admin_if.admin_mode),
		.admin_password(admin_if.admin_password),

		.regs_data_in(register_if.regs_data_in),
		.regs_data_out(register_if.regs_data_out),
		.regs_we(register_if.regs_we),
		.regs_addr(register_if.regs_addr),

		.tamper_detect(errors_if.tamper_detect),
		.jam_detect(errors_if.jam_detect),
		.power_loss(errors_if.power_loss),
        
		.access_error(errors_if.access_error),
		.item_out(user_if.item_out),
		.change_out(user_if.change_out),
		.no_change(user_if.no_change),
		.item_empty(errors_if.item_empty),
		.client_points(user_if.client_points),
		.alarm(errors_if.alarm)
	);
	
	initial begin
		clk = 0;
		forever #5 clk = ~clk;
	end
	
	initial begin	
		rst_n = 0;
		#10; 
		rst_n = 1;	

		#470;
		rst_n = 0;
		#20; 
		rst_n = 1;	

		#470;
		rst_n = 0;
		#20; 
		rst_n = 1;	
	end
	
	initial begin
		$timeformat(-9, 0, " ns", 5);
		
		uvm_config_db #(virtual interface user_interface)::set(null, "*", "user_vif", user_if);
		uvm_config_db #(virtual interface admin_interface)::set(null, "*", "admin_vif", admin_if);
		uvm_config_db #(virtual interface register_interface)::set(null, "*", "register_vif", register_if);
		uvm_config_db #(virtual interface errors_interface)::set(null, "*", "errors_vif", errors_if);
		run_test();
	end
endmodule