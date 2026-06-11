# [BUG] unauthorized_write_register_test failed with seed 12011

## 1. Environment

- **Test Name:** `unauthorized_write_register_test`
- **Group:** `errors_tests`
- **Seed:** `12011`
- **Git Commit:** `42dfb73`
- **Date/Time:** 11.06.2026 20:23:03

## 2. Steps to Reproduce

```bash
python run_tests.py -t unauthorized_write_register_test -s 12011 -v UVM_LOW --skip_compile
```

> Перезапуск с логами интерфейсов:
>
> ```bash
> python run_tests.py -t unauthorized_write_register_test -s 12011 -v UVM_HIGH --skip_compile
> ```

## 3. Extracted Failures

```text
UVM_ERROR
verilog_src/uvm-1.2/src/reg/uvm_reg.svh |Line: 2896
Time: 135 ns | uvm_root              | RegModel: 
Message: Register "reg_block_h.vend_cfg" value read from DUT (0x0000000002014c8a) does not match mirrored value (0x00000000020f0c8a)
```

## 4. Artifacts

- Full simulation log: `sim/runs/unauthorized_write_register_test_seed_12011/sim_log_unauthorized_write_register_test_1.log`
- Waveform file (WLF): `sim/runs/unauthorized_write_register_test_seed_12011/vsim_unauthorized_write_register_test_1.wlf`
