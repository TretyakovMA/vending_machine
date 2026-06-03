`ifndef RESET_TRANSACTION
`define RESET_TRANSACTION
class reset_transaction extends uvm_sequence_item;
    `uvm_object_utils(reset_transaction)
    
    bit         rst_n;  
    rand time   duration;
    rand time   time_delay;
    
    constraint valid_duration { 
        duration > 0; 
        duration < 30;
    }  

    constraint valid_time_delay { 
        time_delay < 1000;
    }

    function new(string name = "reset_transaction");
        super.new(name);
    endfunction: new
    
    function string convert2string();
        return $sformatf("rst_n = %b", rst_n);
    endfunction: convert2string
endclass
`endif