`ifndef ERROR_TRANSACTION
`define ERROR_TRANSACTION
class error_transaction extends base_transaction;

    `uvm_object_utils(error_transaction)

    rand bit             tamper_detect;
    rand bit             jam_detect;
    rand bit             power_loss;

    bit                  access_error;
	bit [`NUM_ITEMS-1:0] item_empty;
	bit                  alarm;

    rand time            time_delay;


    function new(string name = "error_transaction");
		super.new(name);
	endfunction: new


    function string convert2string();
		string s;
		s = $sformatf("Tamper_detect = %b; jam_detect = %b; power_loss = %b; alarm = %b",
			tamper_detect, jam_detect, power_loss, alarm);
		return s;
	endfunction: convert2string


    constraint valid_time_delay {
        time_delay > 0;
        time_delay < 100;
    }

    constraint at_least_one_error {
        int'(tamper_detect) + int'(jam_detect) + int'(power_loss) > 0;
    }
endclass
`endif