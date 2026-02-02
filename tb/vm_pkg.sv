`define NUM_ITEMS 10
`define MAX_CLIENTS 100



`ifndef VM_PKG
`define VM_PKG

`include "interfaces/full_interface.svh"

package vm_pkg;
	timeunit 1ns;
	timeprecision 100ps;
	
	typedef enum bit[1:0] {
		RUB = 2'b00, 
		USD = 2'b01, 
		EUR = 2'b10
	} currency_type_t;
	
	//==============================================================================
	// UVM
	import uvm_pkg::*;
	`include "uvm_macros.svh"
	//==============================================================================



	//==============================================================================
	// Base Classes
	`include "base_classes/base_pkg.sv"
	//==============================================================================



	//==============================================================================
	//Config Classes
	typedef base_agent_config #(virtual user_interface)     user_agent_config;
	typedef base_agent_config #(virtual admin_interface)    admin_agent_config;
	typedef base_agent_config #(virtual register_interface) register_agent_config;
	typedef base_agent_config #(virtual errors_interface)   errors_agent_config;
	//==============================================================================



	//==============================================================================
	//Registers
	`include "register_src/registers/registers_inc.sv"
	//==============================================================================



	//==============================================================================
	// Register Components
	`include "register_src/register_components/register_components_inc.sv"
	//==============================================================================



	//==============================================================================
	// User Components
	`include "user_src/included_files/user_components_inc.svh"
	//==============================================================================
	


	//==============================================================================
	// Admin Components and sequences
	`include "admin_src/admin_src_inc.svh"
	//==============================================================================



	//==============================================================================
	// Errors Components
	`include "errors_src/errors_components/errors_components_inc.sv"
	//==============================================================================
	
	

	//==============================================================================
	// Environment
	`include "enviroment/enviroment_inc.svh"
	//==============================================================================



	//==============================================================================
	// User Sequences
	`include "user_src/included_files/user_sequences_inc.svh"
	//==============================================================================

	//==============================================================================
	// User Tests
	`include "user_src/included_files/user_tests_inc.svh"
	//==============================================================================



	//==============================================================================
	// Register Sequences
	`include "register_src/register_sequences/register_sequences_inc.sv"
	//==============================================================================

	//==============================================================================
	// Register Tests
	`include "register_src/register_tests/register_tests_inc.sv"
	//==============================================================================
	


	//==============================================================================
	// Errors Sequences
	`include "errors_src/errors_sequences/errors_sequences_inc.sv"
	//==============================================================================

	//==============================================================================
	// Errors Tests
	`include "errors_src/errors_tests/errors_tests_inc.sv"
	//==============================================================================




	//==============================================================================
	// Summary Sequences
	`include "summary_tests/summary_sequences/summary_sequences_inc.sv"
	//==============================================================================

	//==============================================================================
	// Summary Tests
	`include "summary_tests/summary_tests_inc.sv"
	//==============================================================================


endpackage
`endif
