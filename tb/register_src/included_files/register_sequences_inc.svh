`ifndef REGISTER_SEQUENCES_INC
`define REGISTER_SEQUENCES_INC

    `include "../register_sequences/register_base_seq.sv"
    `include "../register_sequences/register_base_virtual_seq.sv"
    
    `include "../register_sequences/check_after_reset_seq.sv"
    `include "../register_sequences/check_after_write_seq.sv"

    `include "../register_sequences/change_item_price_seq.sv"
    `include "../register_sequences/write_random_reg_seq.sv"

`endif