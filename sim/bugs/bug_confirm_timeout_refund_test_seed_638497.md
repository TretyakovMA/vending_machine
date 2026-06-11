# [BUG] confirm_timeout_refund_test failed with seed 638497

## 1. Environment

- **Test Name:** `confirm_timeout_refund_test`
- **Group:** `errors_tests`
- **Seed:** `638497`
- **Git Commit:** `42dfb73`
- **Date/Time:** 11.06.2026 20:22:44

## 2. Steps to Reproduce

```bash
python run_tests.py -t confirm_timeout_refund_test -s 638497 -v UVM_LOW --skip_compile
```

> Перезапуск с логами интерфейсов:
>
> ```bash
> python run_tests.py -t confirm_timeout_refund_test -s 638497 -v UVM_HIGH --skip_compile
> ```

## 3. Extracted Failures

```text
UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 322
Time: 1275 ns | vm_scoreboard         | vm_scoreboard: 
Message: Change_out after idle_timeout = 0; expected = 535
```

## 4. Artifacts

- Full simulation log: `sim/runs/confirm_timeout_refund_test_seed_638497/sim_log_confirm_timeout_refund_test_1.log`
- Waveform file (WLF): `sim/runs/confirm_timeout_refund_test_seed_638497/vsim_confirm_timeout_refund_test_1.wlf`
