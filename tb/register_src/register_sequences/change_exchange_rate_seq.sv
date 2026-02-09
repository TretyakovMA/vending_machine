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

        assert (reg_block_h.vend_cfg.randomize());
        value = reg_block_h.vend_cfg.get();
        write_reg(reg_block_h.vend_cfg, status, value);
        value = reg_block_h.vend_cfg.exchange_rate.get();
        `uvm_info(get_type_name(), $sformatf("Set exchange rate to %0d\n\n", value), UVM_LOW)

        reg_block_h.print();
    endtask: body
endclass
`endif