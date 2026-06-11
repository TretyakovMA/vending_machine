# [BUG] write_registers_with_emergency_test failed with seed 959192

## 1. Environment

- **Test Name:** `write_registers_with_emergency_test`
- **Group:** `integration_tests`
- **Seed:** `959192`
- **Git Commit:** `42dfb73`
- **Date/Time:** 11.06.2026 20:21:11

## 2. Steps to Reproduce

```bash
python run_tests.py -t write_registers_with_emergency_test -s 959192 -v UVM_LOW --skip_compile
```

> Перезапуск с логами интерфейсов:
>
> ```bash
> python run_tests.py -t write_registers_with_emergency_test -s 959192 -v UVM_HIGH --skip_compile
> ```

## 3. Extracted Failures

```text
UVM_ERROR
verilog_src/uvm-1.2/src/reg/uvm_reg.svh |Line: 2896
Time: 155 ns | uvm_root              | RegModel: 
Message: Register "reg_block_h.vend_item8" value read from DUT (0x0000000000184017) does not match mirrored value (0x000000000000055a)


UVM_ERROR
verilog_src/uvm-1.2/src/reg/uvm_reg.svh |Line: 2896
Time: 165 ns | uvm_root              | RegModel: 
Message: Register "reg_block_h.vend_item9" value read from DUT (0x0000000000a7d4df) does not match mirrored value (0x0000000000000564)
```

## 4. Artifacts

- Full simulation log: `sim/runs/write_registers_with_emergency_test_seed_959192/sim_log_write_registers_with_emergency_test_1.log`
- Waveform file (WLF): `sim/runs/write_registers_with_emergency_test_seed_959192/vsim_write_registers_with_emergency_test_1.wlf`
