`define NUM_ITEMS 10
`define MAX_CLIENTS 100



`ifndef VM_PKG
`define VM_PKG
package vm_pkg;
	
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
	`include "muvc/muvc_pkg.sv"
	//==============================================================================



	//==============================================================================
	//Config Classes
	typedef muvc_agent_config #(virtual user_interface)     user_agent_config;
	typedef muvc_agent_config #(virtual admin_interface)    admin_agent_config;
	typedef muvc_agent_config #(virtual register_interface) register_agent_config;
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
	`include "user_src/user_components/user_components_inc.sv"
	//==============================================================================
	

	//==============================================================================
	// Admin Components
	`include "admin_src/admin_src_inc.sv"
	//==============================================================================


	

	//==============================================================================
	// Environment
	`include "enviroment/env_config.sv"
	`include "enviroment/env.sv"
	`include "enviroment/base_test.sv"
	`include "enviroment/stimulus_base_test.sv"
	//==============================================================================





	//==============================================================================
	// User Sequences
	`include "user_src/user_sequences/user_sequences_inc.sv"
	//==============================================================================

	//==============================================================================
	// User Tests
	`include "user_src/user_tests/user_tests_inc.sv"
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
	// Summary Sequences
	`include "summary_tests/summary_sequences/summary_sequences_inc.sv"
	//==============================================================================

	//==============================================================================
	// Summary Tests
	`include "summary_tests/summary_tests_inc.sv"
	//==============================================================================


endpackage
`endif
