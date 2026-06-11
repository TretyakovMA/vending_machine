# [BUG] insufficient_funds_test failed with seed 665129

## 1. Environment

- **Test Name:** `insufficient_funds_test`
- **Group:** `errors_tests`
- **Seed:** `665129`
- **Git Commit:** `42dfb73`
- **Date/Time:** 11.06.2026 20:22:07

## 2. Steps to Reproduce

```bash
python run_tests.py -t insufficient_funds_test -s 665129 -v UVM_LOW --skip_compile
```

> Перезапуск с логами интерфейсов:
>
> ```bash
> python run_tests.py -t insufficient_funds_test -s 665129 -v UVM_HIGH --skip_compile
> ```

## 3. Extracted Failures

```text
UVM_FATAL
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 334
Time: 105 ns | vm_scoreboard         | vm_scoreboard: 
Message: No response from DUT
```

## 4. Artifacts

- Full simulation log: `sim/runs/insufficient_funds_test_seed_665129/sim_log_insufficient_funds_test_1.log`
- Waveform file (WLF): `sim/runs/insufficient_funds_test_seed_665129/vsim_insufficient_funds_test_1.wlf`
