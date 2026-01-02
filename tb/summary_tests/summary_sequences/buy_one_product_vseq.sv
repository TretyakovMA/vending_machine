`ifndef BUY_ONE_PRODUCT_VSEQ
`define BUY_ONE_PRODUCT_VSEQ
class buy_one_product_vseq extends summary_base_vseq;

    `uvm_object_utils(buy_one_product_vseq)

    register_test_vseq #(change_item_price_seq) reg_test_vseq;
    buy_one_product_seq                         user_test_seq;
    
    function new(string name = "buy_one_product_vseq");
        super.new(name);
    endfunction

    task body();
        super.body();
        
        reg_test_vseq = register_test_vseq #(change_item_price_seq)::type_id::create("reg_test_vseq");
        user_test_seq = buy_one_product_seq::type_id::create("user_test_seq");

        repeat (1) begin
            //buy_one_seq.start(user_sequencer_h);
            reg_test_vseq.start(null);
            user_test_seq.start(user_sequencer_h);
        end

    endtask: body

endclass
`endif