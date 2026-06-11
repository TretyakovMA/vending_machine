# [BUG] invalid_client_id_test failed with seed 380832

## 1. Environment

- **Test Name:** `invalid_client_id_test`
- **Group:** `errors_tests`
- **Seed:** `380832`
- **Git Commit:** `42dfb73`
- **Date/Time:** 11.06.2026 20:21:29

## 2. Steps to Reproduce

```bash
python run_tests.py -t invalid_client_id_test -s 380832 -v UVM_LOW --skip_compile
```

> Перезапуск с логами интерфейсов:
>
> ```bash
> python run_tests.py -t invalid_client_id_test -s 380832 -v UVM_HIGH --skip_compile
> ```

## 3. Extracted Failures

```text
UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../agents/user_agent/user_transaction.sv |Line: 147
Time: 135 ns | uvm_root              | user_transaction: 
Message: Change issued error:
Get transaction:
-------------------- Input -------------------
  Client_id     = 388
  item_num      = 0
  Coins in:
  [ 0] 50 RUB
  [ 1] 25 EUR
  [ 2]  5 EUR
  [ 3] 10 EUR
-------------------- Output ------------------
  item_out      = 0000000001
  change_out    = 160
  no_change     = 0
  client_points = 0
  item_empty    = 0000000000
----------------------------------------------

Expected:
-------------------- Input -------------------
  Client_id     = 388
  item_num      = 0
  Coins in:
  [ 0] 50 RUB
  [ 1] 25 EUR
  [ 2]  5 EUR
  [ 3] 10 EUR
-------------------- Output ------------------
  item_out      = 0000000001
  change_out    = 161
  no_change     = 0
  client_points = 0
  item_empty    = 0000000000
----------------------------------------------
```

## 4. Artifacts

- Full simulation log: `sim/runs/invalid_client_id_test_seed_380832/sim_log_invalid_client_id_test_1.log`
- Waveform file (WLF): `sim/runs/invalid_client_id_test_seed_380832/vsim_invalid_client_id_test_1.wlf`
