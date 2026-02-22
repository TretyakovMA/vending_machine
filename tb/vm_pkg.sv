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
	// VM_base_classes
	`include "vm_classes/base/base_inc.svh"
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
	// Reset_components
	`include "src/reset_src/included_files/reset_components_inc.svh"
	//==============================================================================



	//==============================================================================
	//Registers
	`include "src/register_src/included_files/registers_inc.svh"
	//==============================================================================



	//==============================================================================
	// Register Components
	`include "src/register_src/included_files/register_components_inc.svh"
	//==============================================================================



	//==============================================================================
	// Emergency Components
	`include "src/emergency_src/included_files/emergency_components_inc.svh"
	//==============================================================================
	


	//==============================================================================
	// User Components
	`include "src/user_src/included_files/user_components_inc.svh"
	//==============================================================================
	


	//==============================================================================
	// Admin Components
	`include "src/admin_src/included_files/admin_components_inc.svh"
	//==============================================================================



	//==============================================================================
	// VM_verification_classes
	`include "vm_classes/verification/verification_inc.svh"
	//==============================================================================



	//==============================================================================
	// Reset sequences
	`include "src/reset_src/included_files/reset_sequences_inc.svh"
	//==============================================================================

	

	//==============================================================================
	// Environment
	`include "enviroment/enviroment_inc.svh"
	//==============================================================================



	//==============================================================================
	// User Sequences
	`include "src/user_src/included_files/user_sequences_inc.svh"
	//==============================================================================

	//==============================================================================
	// User Tests
	`include "src/user_src/included_files/user_tests_inc.svh"
	//==============================================================================



	//==============================================================================
	// Admin Sequences
	`include "src/admin_src/included_files/admin_sequences_inc.svh"
	//==============================================================================
	
	//==============================================================================
	// Register Sequences
	`include "src/register_src/included_files/register_sequences_inc.svh"
	//==============================================================================

	//==============================================================================
	// Register Tests
	`include "src/register_src/included_files/register_tests_inc.svh"
	//==============================================================================
	


	//==============================================================================
	// Emergency Sequences
	`include "src/emergency_src/included_files/emergency_sequences_inc.svh"
	//==============================================================================

	//==============================================================================
	// Emergency Tests
	`include "src/emergency_src/included_files/emergency_tests_inc.svh"
	//==============================================================================




	//==============================================================================
	// Integration Sequences
	`include "src/integration_src/included_files/integration_sequences_inc.svh"
	//==============================================================================

	//==============================================================================
	// Integration Tests
	`include "src/integration_src/included_files/integration_tests_inc.svh"
	//==============================================================================


endpackage
`endif
