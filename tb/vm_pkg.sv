`define NUM_ITEMS 10
`define MAX_CLIENTS 100



`ifndef VM_PKG
`define VM_PKG

`include "interfaces/full_interface.svh"

package vm_pkg;
	timeunit      1ns;
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
	typedef base_agent_config #(virtual error_interface)    error_agent_config;
	//==============================================================================



	//==============================================================================
	//Registers
	`include "register_src/included_files/registers_inc.svh"
	//==============================================================================



	//==============================================================================
	// Register Components
	`include "register_src/included_files/register_components_inc.svh"
	//==============================================================================



	//==============================================================================
	// Error Components
	`include "error_src/included_files/error_components_inc.svh"
	//==============================================================================
	


	//==============================================================================
	// User Components
	`include "user_src/included_files/user_components_inc.svh"
	//==============================================================================
	


	//==============================================================================
	// Admin Components
	`include "admin_src/included_files/admin_components_inc.svh"
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
	// Admin Sequences
	`include "admin_src/included_files/admin_sequences_inc.svh"
	//==============================================================================

	//==============================================================================
	// Register Sequences
	`include "register_src/included_files/register_sequences_inc.svh"
	//==============================================================================

	//==============================================================================
	// Register Tests
	`include "register_src/included_files/register_tests_inc.svh"
	//==============================================================================
	


	//==============================================================================
	// Error Sequences
	`include "error_src/included_files/error_sequences_inc.svh"
	//==============================================================================

	//==============================================================================
	// Error Tests
	`include "error_src/included_files/error_tests_inc.svh"
	//==============================================================================




	//==============================================================================
	// Integration Sequences
	`include "integration_src/included_files/integration_sequences_inc.svh"
	//==============================================================================

	//==============================================================================
	// Integration Tests
	`include "integration_src/included_files/integration_tests_inc.svh"
	//==============================================================================


endpackage
`endif
