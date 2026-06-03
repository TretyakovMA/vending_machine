`ifndef CHANGE_EXCHANGE_RATE_SEQ
`define CHANGE_EXCHANGE_RATE_SEQ
class change_exchange_rate_seq extends register_base_seq;

    `uvm_object_utils(change_exchange_rate_seq)
    
    function new(string name = "change_exchange_rate_seq");
        super.new(name);
    endfunction

    task body();
        super.body();

        assert (reg_block_h.vend_cfg.exchange_rate.randomize() with {
            value inside {1, 3};
        });
        value = reg_block_h.vend_cfg.get();
        write_reg(reg_block_h.vend_cfg, status, value);

        value = reg_block_h.vend_cfg.exchange_rate.get();
        `uvm_info(get_type_name(), $sformatf("Set exchange rate to %0d", value), UVM_HIGH)

        reg_block_h.print();
    endtask: body
endclass
`endif