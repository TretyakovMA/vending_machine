`ifndef ERROR_SCOREBOARD
`define ERROR_SCOREBOARD
class error_scoreboard extends uvm_scoreboard;

    `uvm_component_utils(error_scoreboard)

    uvm_analysis_imp #(error_transaction, error_scoreboard) a_imp;

    function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new

    function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		a_imp = new("a_imp", this);
	endfunction: build_phase

    function void write (error_transaction t);
        if (t.alarm != 1) begin
            `uvm_error(get_type_name(), $sformatf("Alarm should be 1 when error signals are active. Received transaction: %s", t.convert2string()))
        end 
        else begin
            `uvm_info(get_type_name(), $sformatf("Received transaction: %s", t.convert2string()), UVM_LOW)
        end
    endfunction: write
endclass
`endif