# [BUG] coin_timeout_refund_test failed with seed 989556

## 1. Environment

- **Test Name:** `coin_timeout_refund_test`
- **Group:** `errors_tests`
- **Seed:** `989556`
- **Git Commit:** `42dfb73`
- **Date/Time:** 11.06.2026 20:22:26

## 2. Steps to Reproduce

```bash
python run_tests.py -t coin_timeout_refund_test -s 989556 -v UVM_LOW --skip_compile
```

> Перезапуск с логами интерфейсов:
>
> ```bash
> python run_tests.py -t coin_timeout_refund_test -s 989556 -v UVM_HIGH --skip_compile
> ```

## 3. Extracted Failures

```text
UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 322
Time: 1275 ns | vm_scoreboard         | vm_scoreboard: 
Message: Change_out after idle_timeout = 0; expected = 3
```

## 4. Artifacts

- Full simulation log: `sim/runs/coin_timeout_refund_test_seed_989556/sim_log_coin_timeout_refund_test_1.log`
- Waveform file (WLF): `sim/runs/coin_timeout_refund_test_seed_989556/vsim_coin_timeout_refund_test_1.wlf`
