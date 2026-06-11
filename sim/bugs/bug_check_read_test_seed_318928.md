# [BUG] check_read_test failed with seed 318928

## 1. Environment

- **Test Name:** `check_read_test`
- **Group:** `register_tests`
- **Seed:** `318928`
- **Git Commit:** `42dfb73`
- **Date/Time:** 11.06.2026 20:18:13

## 2. Steps to Reproduce

```bash
python run_tests.py -t check_read_test -s 318928 -v UVM_LOW --skip_compile
```

> Перезапуск с логами интерфейсов:
>
> ```bash
> python run_tests.py -t check_read_test -s 318928 -v UVM_HIGH --skip_compile
> ```

## 3. Extracted Failures

```text
UVM_ERROR
verilog_src/uvm-1.2/src/reg/uvm_reg.svh |Line: 2896
Time: 175 ns | uvm_root              | RegModel: 
Message: Register "reg_block_h.vend_item1" value read from DUT (0x0000000000000059) does not match mirrored value (0x0000000000059a40)


UVM_ERROR
verilog_src/uvm-1.2/src/reg/uvm_reg.svh |Line: 2896
Time: 195 ns | uvm_root              | RegModel: 
Message: Register "reg_block_h.vend_item6" value read from DUT (0x0000000000000025) does not match mirrored value (0x00000000000f142e)


UVM_ERROR
verilog_src/uvm-1.2/src/reg/uvm_reg.svh |Line: 2896
Time: 205 ns | uvm_root              | RegModel: 
Message: Register "reg_block_h.vend_item9" value read from DUT (0x000000000000009b) does not match mirrored value (0x00000000004653fc)


UVM_ERROR
verilog_src/uvm-1.2/src/reg/uvm_reg.svh |Line: 2896
Time: 215 ns | uvm_root              | RegModel: 
Message: Register "reg_block_h.vend_item8" value read from DUT (0x0000000000000068) does not match mirrored value (0x0000000000164e50)


UVM_ERROR
verilog_src/uvm-1.2/src/reg/uvm_reg.svh |Line: 2896
Time: 225 ns | uvm_root              | RegModel: 
Message: Register "reg_block_h.vend_item3" value read from DUT (0x000000000000009a) does not match mirrored value (0x00000000002c9025)


UVM_ERROR
verilog_src/uvm-1.2/src/reg/uvm_reg.svh |Line: 2896
Time: 235 ns | uvm_root              | RegModel: 
Message: Register "reg_block_h.vend_item4" value read from DUT (0x0000000000000034) does not match mirrored value (0x0000000000669b68)


UVM_ERROR
verilog_src/uvm-1.2/src/reg/uvm_reg.svh |Line: 2896
Time: 255 ns | uvm_root              | RegModel: 
Message: Register "reg_block_h.vend_item0" value read from DUT (0x00000000000000ed) does not match mirrored value (0x0000000000f159ed)


UVM_ERROR
verilog_src/uvm-1.2/src/reg/uvm_reg.svh |Line: 2896
Time: 265 ns | uvm_root              | RegModel: 
Message: Register "reg_block_h.vend_item2" value read from DUT (0x0000000000000040) does not match mirrored value (0x0000000000320f34)


UVM_ERROR
verilog_src/uvm-1.2/src/reg/uvm_reg.svh |Line: 2896
Time: 275 ns | uvm_root              | RegModel: 
Message: Register "reg_block_h.vend_item5" value read from DUT (0x000000000000000f) does not match mirrored value (0x000000000068cbf7)


UVM_ERROR
verilog_src/uvm-1.2/src/reg/uvm_reg.svh |Line: 2896
Time: 285 ns | uvm_root              | RegModel: 
Message: Register "reg_block_h.vend_item7" value read from DUT (0x0000000000000090) does not match mirrored value (0x000000000029224d)
```

## 4. Artifacts

- Full simulation log: `sim/runs/check_read_test_seed_318928/sim_log_check_read_test_1.log`
- Waveform file (WLF): `sim/runs/check_read_test_seed_318928/vsim_check_read_test_1.wlf`
