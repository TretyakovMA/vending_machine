`ifndef USER_COMPONENTS_INC
`define USER_COMPONENTS_INC

    `include "../user_components/user_transaction.sv"
    `include "../user_components/user_coverage.sv"
    `include "../user_components/user_checker.sv"
    `include "../user_components/user_scoreboard.sv"
    typedef uvm_sequencer #(user_transaction) user_sequencer;
    `include "../user_components/user_driver.sv"
    `include "../user_components/user_monitor.sv"
    `include "../user_components/user_agent.sv"

`endif