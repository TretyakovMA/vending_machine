`ifndef BASE_PKG
`define BASE_PKG
//package base_pkg;
	
	// В будущем это будет пакет базовых классов
	
	//import uvm_pkg::*;
	//`include "uvm_macros.svh"
	
    `include "void_monitor.sv"
    `include "void_driver.sv"
    
	`include "base_agent_config.sv"
	`include "base_driver.sv"
	`include "base_monitor.sv"
	
	`include "base_agent.sv"

	
//endpackage
`endif
