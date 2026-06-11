# [BUG] client_session_after_change_exchange_rate_test failed with seed 743288

## 1. Environment

- **Test Name:** `client_session_after_change_exchange_rate_test`
- **Group:** `integration_tests`
- **Seed:** `743288`
- **Git Commit:** `42dfb73`
- **Date/Time:** 11.06.2026 20:20:14

## 2. Steps to Reproduce

```bash
python run_tests.py -t client_session_after_change_exchange_rate_test -s 743288 -v UVM_LOW --skip_compile
```

> Перезапуск с логами интерфейсов:
>
> ```bash
> python run_tests.py -t client_session_after_change_exchange_rate_test -s 743288 -v UVM_HIGH --skip_compile
> ```

## 3. Extracted Failures

```text
UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../agents/user_agent/user_transaction.sv |Line: 147
Time: 265 ns | uvm_root              | user_transaction: 
Message: Change issued error:
Get transaction:
-------------------- Input -------------------
  Client_id     = 22
  item_num      = 0
  Coins in:
  [ 0]  1 EUR
  [ 1] 50 EUR
  [ 2]  1 RUB
  [ 3] 10 USD
-------------------- Output ------------------
  item_out      = 0000000001
  change_out    = 78
  no_change     = 0
  client_points = 2
  item_empty    = 0000000000
----------------------------------------------

Expected:
-------------------- Input -------------------
  Client_id     = 22
  item_num      = 0
  Coins in:
  [ 0]  1 EUR
  [ 1] 50 EUR
  [ 2]  1 RUB
  [ 3] 10 USD
-------------------- Output ------------------
  item_out      = 0000000001
  change_out    = 79
  no_change     = 0
  client_points = 2
  item_empty    = 0000000000
----------------------------------------------


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../agents/user_agent/user_transaction.sv |Line: 147
Time: 485 ns | uvm_root              | user_transaction: 
Message: Change issued error:
Get transaction:
-------------------- Input -------------------
  Client_id     = 41
  item_num      = 2
  Coins in:
  [ 0] 25 EUR
-------------------- Output ------------------
  item_out      = 0000000100
  change_out    = 13
  no_change     = 0
  client_points = 2
  item_empty    = 0000000000
----------------------------------------------

Expected:
-------------------- Input -------------------
  Client_id     = 41
  item_num      = 2
  Coins in:
  [ 0] 25 EUR
-------------------- Output ------------------
  item_out      = 0000000100
  change_out    = 14
  no_change     = 0
  client_points = 2
  item_empty    = 0000000000
----------------------------------------------


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../agents/user_agent/user_transaction.sv |Line: 147
Time: 605 ns | uvm_root              | user_transaction: 
Message: Change issued error:
Get transaction:
-------------------- Input -------------------
  Client_id     = 11
  item_num      = 1
  Coins in:
  [ 0]  1 USD
  [ 1]  5 USD
  [ 2] 50 USD
  [ 3]  1 EUR
-------------------- Output ------------------
  item_out      = 0000000010
  change_out    = 41
  no_change     = 0
  client_points = 11
  item_empty    = 0000000000
----------------------------------------------

Expected:
-------------------- Input -------------------
  Client_id     = 11
  item_num      = 1
  Coins in:
  [ 0]  1 USD
  [ 1]  5 USD
  [ 2] 50 USD
  [ 3]  1 EUR
-------------------- Output ------------------
  item_out      = 0000000010
  change_out    = 42
  no_change     = 0
  client_points = 11
  item_empty    = 0000000000
----------------------------------------------


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../agents/user_agent/user_transaction.sv |Line: 147
Time: 835 ns | uvm_root              | user_transaction: 
Message: Change issued error:
Get transaction:
-------------------- Input -------------------
  Client_id     = 83
  item_num      = 7
  Coins in:
  [ 0]  1 EUR  [10] 10 RUB
  [ 1] 25 USD  [11]  1 RUB
  [ 2] 25 EUR  [12]  1 USD
  [ 3]  1 EUR  [13] 50 USD
  [ 4]  5 RUB  [14]  5 USD
  [ 5]  5 USD
  [ 6] 25 EUR
  [ 7] 10 USD
  [ 8]  1 USD
  [ 9]  1 EUR
-------------------- Output ------------------
  item_out      = 0010000000
  change_out    = 126
  no_change     = 0
  client_points = 6
  item_empty    = 0000000000
----------------------------------------------

Expected:
-------------------- Input -------------------
  Client_id     = 83
  item_num      = 7
  Coins in:
  [ 0]  1 EUR  [10] 10 RUB
  [ 1] 25 USD  [11]  1 RUB
  [ 2] 25 EUR  [12]  1 USD
  [ 3]  1 EUR  [13] 50 USD
  [ 4]  5 RUB  [14]  5 USD
  [ 5]  5 USD
  [ 6] 25 EUR
  [ 7] 10 USD
  [ 8]  1 USD
  [ 9]  1 EUR
-------------------- Output ------------------
  item_out      = 0010000000
  change_out    = 129
  no_change     = 0
  client_points = 6
  item_empty    = 0000000000
----------------------------------------------


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../agents/user_agent/user_transaction.sv |Line: 147
Time: 955 ns | uvm_root              | user_transaction: 
Message: Change issued error:
Get transaction:
-------------------- Input -------------------
  Client_id     = 82
  item_num      = 3
  Coins in:
  [ 0] 25 EUR
  [ 1] 50 EUR
  [ 2] 10 EUR
  [ 3]  5 RUB
-------------------- Output ------------------
  item_out      = 0000001000
  change_out    = 96
  no_change     = 0
  client_points = 3
  item_empty    = 0000000000
----------------------------------------------

Expected:
-------------------- Input -------------------
  Client_id     = 82
  item_num      = 3
  Coins in:
  [ 0] 25 EUR
  [ 1] 50 EUR
  [ 2] 10 EUR
  [ 3]  5 RUB
-------------------- Output ------------------
  item_out      = 0000001000
  change_out    = 97
  no_change     = 0
  client_points = 3
  item_empty    = 0000000000
----------------------------------------------


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../agents/user_agent/user_transaction.sv |Line: 147
Time: 1235 ns | uvm_root              | user_transaction: 
Message: Change issued error:
Get transaction:
-------------------- Input -------------------
  Client_id     = 81
  item_num      = 9
  Coins in:
  [ 0] 50 USD  [10] 50 EUR
  [ 1] 50 USD
  [ 2]  1 USD
  [ 3] 25 EUR
  [ 4]  1 USD
  [ 5]  1 EUR
  [ 6] 25 USD
  [ 7] 25 RUB
  [ 8]  5 EUR
  [ 9] 50 RUB
-------------------- Output ------------------
  item_out      = 1000000000
  change_out    = 222
  no_change     = 0
  client_points = 6
  item_empty    = 0000000000
----------------------------------------------

Expected:
-------------------- Input -------------------
  Client_id     = 81
  item_num      = 9
  Coins in:
  [ 0] 50 USD  [10] 50 EUR
  [ 1] 50 USD
  [ 2]  1 USD
  [ 3] 25 EUR
  [ 4]  1 USD
  [ 5]  1 EUR
  [ 6] 25 USD
  [ 7] 25 RUB
  [ 8]  5 EUR
  [ 9] 50 RUB
-------------------- Output ------------------
  item_out      = 1000000000
  change_out    = 224
  no_change     = 0
  client_points = 6
  item_empty    = 0000000000
----------------------------------------------


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../agents/user_agent/user_transaction.sv |Line: 147
Time: 1345 ns | uvm_root              | user_transaction: 
Message: Change issued error:
Get transaction:
-------------------- Input -------------------
  Client_id     = 58
  item_num      = 2
  Coins in:
  [ 0]  5 EUR
  [ 1] 50 EUR
  [ 2] 10 USD
-------------------- Output ------------------
  item_out      = 0000000100
  change_out    = 65
  no_change     = 0
  client_points = 19
  item_empty    = 0000000000
----------------------------------------------

Expected:
-------------------- Input -------------------
  Client_id     = 58
  item_num      = 2
  Coins in:
  [ 0]  5 EUR
  [ 1] 50 EUR
  [ 2] 10 USD
-------------------- Output ------------------
  item_out      = 0000000100
  change_out    = 66
  no_change     = 0
  client_points = 19
  item_empty    = 0000000000
----------------------------------------------
```

## 4. Artifacts

- Full simulation log: `sim/runs/client_session_after_change_exchange_rate_test_seed_743288/sim_log_client_session_after_change_exchange_rate_test_1.log`
- Waveform file (WLF): `sim/runs/client_session_after_change_exchange_rate_test_seed_743288/vsim_client_session_after_change_exchange_rate_test_1.wlf`
