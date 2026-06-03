`ifndef VM_PKG
`define VM_PKG


`define NUM_ITEMS 10
`define MAX_CLIENTS 100

// Interfaces
`include "include/interfaces_inc.svh"

package vm_pkg;
	timeunit      1ns;
	timeprecision 1ns;
	
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
	`include "uvm_base_classes/base_classes_pkg.sv"
	//==============================================================================



	//==============================================================================
	// Agent_config classes
	typedef base_agent_config #(virtual reset_interface)     reset_agent_config;
	typedef base_agent_config #(virtual user_interface)      user_agent_config;
	typedef base_agent_config #(virtual admin_interface)     admin_agent_config;
	typedef base_agent_config #(virtual register_interface)  register_agent_config;
	typedef base_agent_config #(virtual emergency_interface) emergency_agent_config;
	//==============================================================================


	//==============================================================================
	// Registers
	`include "include/registers_inc.svh"
	//==============================================================================



	//==============================================================================
	// Callbacks
	`include "include/callbacks_inc.svh"
	//==============================================================================



	//==============================================================================
	// Agents

	// Reset agent
	`include "include/reset_agent_inc.svh"

	// Register agent
	`include "include/register_agent_inc.svh"
	
	// Emergency agent
	`include "include/emergency_agent_inc.svh"
	
	// User agent
	`include "include/user_agent_inc.svh"

	// Admin agent
	`include "include/admin_agent_inc.svh"
	//==============================================================================



	
	// Scoreboard
	`include "include/scoreboard_inc.svh"
	// Coverage
	`include "include/coverage_inc.svh"



	//==============================================================================
	// Sequences

	// Reset sequences
	`include "include/reset_sequences_inc.svh"

	// User Sequences
	`include "include/user_sequences_inc.svh"
	
	// Admin Sequences
	`include "include/admin_sequences_inc.svh"
	
	// Register Sequences
	`include "include/register_sequences_inc.svh"
	
	// Emergency Sequences
	`include "include/emergency_sequences_inc.svh"
	
	// Integration Sequences
	`include "include/integration_sequences_inc.svh"
	//==============================================================================

	

	//==============================================================================
	// Environment
	`include "include/environment_inc.svh"
	//==============================================================================



	
	//==============================================================================
	// Tests
	
	// User Tests
	`include "include/user_tests_inc.svh"
	
	// Register Tests
	`include "include/register_tests_inc.svh"
	
	// Emergency Tests
	`include "include/emergency_tests_inc.svh"
	
	// Integration Tests
	`include "include/integration_tests_inc.svh"
	//==============================================================================


endpackage
`endif
