`define NUM_ITEMS 10
`define MAX_CLIENTS 100


`ifndef VM_PKG
`define VM_PKG
package vm_pkg;
	timeunit 1ns;
	timeprecision 1ps;
	typedef enum logic[1:0] {RUB, USD, EUR} currency_type_t;
	
	
	import uvm_pkg::*;
	`include "uvm_macros.svh"

	import base_pkg::*;

	typedef base_agent_config #(virtual user_interface)     user_agent_config;
	typedef base_agent_config #(virtual admin_interface)    admin_agent_config;
	typedef base_agent_config #(virtual register_interface) register_agent_config;
	
	
	`include "user_src/user_components/user_transaction.sv"
	`include "register_src/register_components/register_transaction.sv"
	`include "admin_src/admin_transaction.sv"

	
	
	
	`include "config/env_config.sv"

	`include "register_src/registers/vend_cfg_reg.sv"
	`include "register_src/registers/vend_clients_reg.sv"
	`include "register_src/registers/vend_item_reg.sv"
	`include "register_src/registers/vend_paswd_reg.sv"
	`include "register_src/registers/vm_reg_block.sv"

	typedef uvm_sequencer     #(register_transaction) register_sequencer;
	typedef uvm_reg_predictor #(register_transaction) register_predictor;
	`include "register_src/register_components/register_driver.sv"
	`include "register_src/register_components/register_monitor.sv"
	`include "register_src/register_components/register_adapter.sv"
	`include "register_src/register_components/register_agent.sv"
	`include "register_src/register_components/register_env.sv"




	`include "user_src/user_components/user_coverage.sv"
	`include "user_src/user_components/user_scoreboard.sv"
	typedef uvm_sequencer #(user_transaction) user_sequencer;
	`include "user_src/user_components/user_driver.sv"
	`include "user_src/user_components/user_monitor.sv"
	`include "user_src/user_components/user_agent.sv"
	
	
	
	
	
	typedef uvm_sequencer #(admin_transaction) admin_sequencer;
	`include "admin_src/admin_driver.sv"
	`include "admin_src/admin_agent.sv"
	


	
	
	`include "env.sv"
	`include "base_classes/base_test.sv"


	
	`include "user_src/user_sequences/simple_test_seq.sv"
	`include "user_src/user_sequences/test_one_coin_seq.sv"
	`include "user_src/user_sequences/test_few_coin_seq.sv"
	`include "user_src/user_sequences/test_dollars_seq.sv"
	`include "user_src/user_sequences/test_euros_seq.sv"
	`include "user_src/user_sequences/test_random_client_with_no_change_seq.sv"
	`include "user_src/user_sequences/full_client_session_with_no_errors_seq.sv"
	`include "user_src/user_sequences/test_lots_of_purchases_seq.sv"
	
	`include "user_src/user_tests/simple_test.sv"
	`include "user_src/user_tests/test_one_coin.sv"
	`include "user_src/user_tests/test_few_coin.sv"
	`include "user_src/user_tests/test_dollars.sv"
	`include "user_src/user_tests/test_euros.sv"
	`include "user_src/user_tests/test_random_client_with_no_change.sv"
	`include "user_src/user_tests/full_client_session_with_no_errors.sv"
	`include "user_src/user_tests/test_lots_of_purchases.sv"



	`include "admin_src/admin_mode_on_seq.sv"
	`include "admin_src/admin_mode_off_seq.sv"

	`include "register_src/register_sequences/reset_test_seq.sv"
	`include "register_src/register_sequences/register_test_vseq.sv"
	
	`include "register_src/register_tests/reset_test.sv"
	`include "register_src/register_tests/register_test.sv"
	
endpackage
`endif
