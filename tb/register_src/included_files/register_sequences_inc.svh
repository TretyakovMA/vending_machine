`ifndef REGISTER_SEQUENCES_INC
`define REGISTER_SEQUENCES_INC

    `include "../register_sequences/register_base_seq.sv"
    `include "../register_sequences/register_base_virtual_seq.sv"
    
    `include "../register_sequences/read_after_reset_test_seq.sv"
    `include "../register_sequences/read_after_write_test_seq.sv"
    `include "../register_sequences/change_item_price_seq.sv"
    `include "../register_sequences/write_random_reg_seq.sv"

`endif