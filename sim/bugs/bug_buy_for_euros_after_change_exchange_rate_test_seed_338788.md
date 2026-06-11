# [BUG] buy_for_euros_after_change_exchange_rate_test failed with seed 338788

## 1. Environment

- **Test Name:** `buy_for_euros_after_change_exchange_rate_test`
- **Group:** `integration_tests`
- **Seed:** `338788`
- **Git Commit:** `42dfb73`
- **Date/Time:** 11.06.2026 20:19:56

## 2. Steps to Reproduce

```bash
python run_tests.py -t buy_for_euros_after_change_exchange_rate_test -s 338788 -v UVM_LOW --skip_compile
```

> Перезапуск с логами интерфейсов:
>
> ```bash
> python run_tests.py -t buy_for_euros_after_change_exchange_rate_test -s 338788 -v UVM_HIGH --skip_compile
> ```

## 3. Extracted Failures

```text
UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../agents/user_agent/user_transaction.sv |Line: 147
Time: 165 ns | uvm_root              | user_transaction: 
Message: Change issued error:
Get transaction:
-------------------- Input -------------------
  Client_id     = 65
  item_num      = 2
  Coins in:
  [ 0] 25 EUR
  [ 1]  5 EUR
  [ 2] 10 EUR
  [ 3]  1 EUR
-------------------- Output ------------------
  item_out      = 0000000100
  change_out    = 159
  no_change     = 0
  client_points = 6
  item_empty    = 0000000000
----------------------------------------------

Expected:
-------------------- Input -------------------
  Client_id     = 65
  item_num      = 2
  Coins in:
  [ 0] 25 EUR
  [ 1]  5 EUR
  [ 2] 10 EUR
  [ 3]  1 EUR
-------------------- Output ------------------
  item_out      = 0000000100
  change_out    = 161
  no_change     = 0
  client_points = 6
  item_empty    = 0000000000
----------------------------------------------
```

## 4. Artifacts

- Full simulation log: `sim/runs/buy_for_euros_after_change_exchange_rate_test_seed_338788/sim_log_buy_for_euros_after_change_exchange_rate_test_1.log`
- Waveform file (WLF): `sim/runs/buy_for_euros_after_change_exchange_rate_test_seed_338788/vsim_buy_for_euros_after_change_exchange_rate_test_1.wlf`
