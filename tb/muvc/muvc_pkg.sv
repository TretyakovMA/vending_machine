`ifndef MUVC_PKG
`define MUVC_PKG

	
	
	//import uvm_pkg::*;
	//`include "uvm_macros.svh"

	
	`include "muvc_report_server.sv"
	
    `include "void_monitor.sv"
    `include "void_driver.sv"
    
	`include "muvc_agent_config.sv"
	`include "muvc_driver.sv"
	`include "muvc_monitor.sv"
	
	`include "muvc_agent.sv"

	
`endif
