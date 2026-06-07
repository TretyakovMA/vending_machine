`ifndef VM_REG_ACCESS_CB
`define VM_REG_ACCESS_CB
class vm_reg_access_cb extends uvm_reg_cbs;
    `uvm_object_utils(vm_reg_access_cb)

    // Этот флаг будет устанавливать scoreboard
    bit write_should_be_ignored = 0;

    function new(string name = "vm_reg_access_cb");
        super.new(name);
    endfunction: new
    
    virtual function void post_predict(input uvm_reg_field  fld,
                               input uvm_reg_data_t previous,
                               inout uvm_reg_data_t value,
                               input uvm_predict_e  kind,
                               input uvm_path_e     path,
                               input uvm_reg_map    map);

        if (write_should_be_ignored) begin
            value = previous; // Игнорируем запись, возвращая старое значение
        end

    endfunction: post_predict
    
endclass
`endif