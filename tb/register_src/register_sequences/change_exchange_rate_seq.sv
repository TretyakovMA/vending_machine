`ifndef CHANGE_EXCHANGE_RATE_SEQ
`define CHANGE_EXCHANGE_RATE_SEQ
class change_exchange_rate_seq extends register_base_seq;

    `uvm_object_utils(change_exchange_rate_seq)
    
    function new(string name = "change_exchange_rate_seq");
        super.new(name);
    endfunction

    task body();
        super.body();

        reg_block_h.vend_cfg.idle_timeout.rand_mode(0);
        reg_block_h.vend_cfg.max_coins.rand_mode(0);

        write_random_value(reg_block_h.vend_cfg);

        value = reg_block_h.vend_cfg.exchange_rate.get();
        `uvm_info(get_type_name(), $sformatf("Set exchange rate to %0d", value), UVM_HIGH)

        reg_block_h.print();
    endtask: body
endclass
`endif