`ifndef ERRORS_TRANSACTION
`define ERRORS_TRANSACTION
class errors_transaction extends uvm_sequence_item;

    `uvm_object_utils(errors_transaction)

    rand bit             tamper_detect;
    rand bit             jam_detect;
    rand bit             power_loss;

    bit                  access_error;
	bit [`NUM_ITEMS-1:0] item_empty;
	bit                  alarm;

    rand time            time_delay;


    function new(string name = "errors_transaction");
		super.new(name);
	endfunction: new


    function string convert2string();
		string s;
		s = $sformatf("Tamper_detect = %b; jam_detect = %b; power_loss = %b; time_delay = %t; access_error = %b; item_empty = %b; alarm = %b",
			tamper_detect, jam_detect, power_loss, time_delay, access_error, item_empty, alarm);
		return s;
	endfunction: convert2string


    constraint valid_time_delay {
        time_delay > 0;
        time_delay < 100;
    }
endclass
`endif