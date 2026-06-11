# [BUG] check_after_reset_test failed with seed 740314

## 1. Environment

- **Test Name:** `check_after_reset_test`
- **Group:** `register_tests`
- **Seed:** `740314`
- **Git Commit:** `42dfb73`
- **Date/Time:** 11.06.2026 20:17:35

## 2. Steps to Reproduce

```bash
python run_tests.py -t check_after_reset_test -s 740314 -v UVM_LOW --skip_compile
```

> Перезапуск с логами интерфейсов:
>
> ```bash
> python run_tests.py -t check_after_reset_test -s 740314 -v UVM_HIGH --skip_compile
> ```

## 3. Extracted Failures

```text
UVM_ERROR
verilog_src/uvm-1.2/src/reg/uvm_reg.svh |Line: 2896
Time: 25 ns | uvm_root              | RegModel: 
Message: Register "reg_block_h.vend_cfg" value read from DUT (0x0000000002014c8a) does not match mirrored value (0x00000000020f0c8a)
```

## 4. Artifacts

- Full simulation log: `sim/runs/check_after_reset_test_seed_740314/sim_log_check_after_reset_test_1.log`
- Waveform file (WLF): `sim/runs/check_after_reset_test_seed_740314/vsim_check_after_reset_test_1.wlf`
