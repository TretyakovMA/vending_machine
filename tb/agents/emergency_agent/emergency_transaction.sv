`ifndef EMERGENCY_TRANSACTION
`define EMERGENCY_TRANSACTION
class emergency_transaction extends uvm_sequence_item;

    `uvm_object_utils(emergency_transaction)

    rand bit             tamper_detect;
    rand bit             jam_detect;
    rand bit             power_loss;

    rand time            time_delay;

	bit                  alarm;


    function new(string name = "emergency_transaction");
		super.new(name);
	endfunction: new


    function string convert2string();
		string s;
		s = $sformatf("Tamper_detect = %b; jam_detect = %b; power_loss = %b; alarm = %b",
			tamper_detect, jam_detect, power_loss, alarm);
		return s;
	endfunction: convert2string


    constraint valid_time_delay {
        time_delay > 10;
        time_delay < 200;
    }

    constraint at_least_one_error {
        int'(tamper_detect) + int'(jam_detect) + int'(power_loss) > 0;
    }
endclass
`endif