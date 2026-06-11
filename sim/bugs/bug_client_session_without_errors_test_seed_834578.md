# [BUG] client_session_without_errors_test failed with seed 834578

## 1. Environment

- **Test Name:** `client_session_without_errors_test`
- **Group:** `user_tests`
- **Seed:** `834578`
- **Git Commit:** `42dfb73`
- **Date/Time:** 11.06.2026 20:17:16

## 2. Steps to Reproduce

```bash
python run_tests.py -t client_session_without_errors_test -s 834578 -v UVM_LOW --skip_compile
```

> Перезапуск с логами интерфейсов:
>
> ```bash
> python run_tests.py -t client_session_without_errors_test -s 834578 -v UVM_HIGH --skip_compile
> ```

## 3. Extracted Failures

```text
UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 5055 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000100000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 5295 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 1000000000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 5525 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000010000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 6255 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 1000000000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 6405 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0001000000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 6675 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000100000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 7135 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000010000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 7275 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000100000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 7655 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0010000000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 7795 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000010000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 8025 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000010000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 8245 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000010000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 8595 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000010000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 8735 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0001000000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 8885 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000010000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 9105 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000100000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 9375 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000010000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 9645 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0100000000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../agents/user_agent/user_transaction.sv |Line: 163
Time: 9895 ns | uvm_root              | user_transaction: 
Message: Points accrual error:
Get transaction:
-------------------- Input -------------------
  Client_id     = 28
  item_num      = 1
  Coins in:
  [ 0]  1 RUB
  [ 1]  5 USD
  [ 2] 10 EUR
  [ 3]  1 USD
  [ 4] 25 USD
  [ 5]  5 USD
-------------------- Output ------------------
  item_out      = 0000000010
  change_out    = 85
  no_change     = 0
  client_points = 10
  item_empty    = 0000000000
----------------------------------------------

Expected:
-------------------- Input -------------------
  Client_id     = 28
  item_num      = 1
  Coins in:
  [ 0]  1 RUB
  [ 1]  5 USD
  [ 2] 10 EUR
  [ 3]  1 USD
  [ 4] 25 USD
  [ 5]  5 USD
-------------------- Output ------------------
  item_out      = 0000000010
  change_out    = 85
  no_change     = 0
  client_points = 8
  item_empty    = 0000000000
----------------------------------------------


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 10125 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0100000000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../agents/user_agent/user_transaction.sv |Line: 163
Time: 10275 ns | uvm_root              | user_transaction: 
Message: Points accrual error:
Get transaction:
-------------------- Input -------------------
  Client_id     = 57
  item_num      = 0
  Coins in:
  [ 0] 10 USD
  [ 1]  1 USD
  [ 2] 10 USD
  [ 3]  1 RUB
  [ 4] 10 EUR
  [ 5] 50 USD
  [ 6] 10 USD
-------------------- Output ------------------
  item_out      = 0000000001
  change_out    = 183
  no_change     = 0
  client_points = 19
  item_empty    = 0000000000
----------------------------------------------

Expected:
-------------------- Input -------------------
  Client_id     = 57
  item_num      = 0
  Coins in:
  [ 0] 10 USD
  [ 1]  1 USD
  [ 2] 10 USD
  [ 3]  1 RUB
  [ 4] 10 EUR
  [ 5] 50 USD
  [ 6] 10 USD
-------------------- Output ------------------
  item_out      = 0000000001
  change_out    = 183
  no_change     = 0
  client_points = 17
  item_empty    = 0000000000
----------------------------------------------


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 10705 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 1000000000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 11105 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0010000000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 12205 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000000010


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 12335 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000000010


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 13305 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000000100


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 14325 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000000100


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 14455 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0010000000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 14765 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0010000000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 15025 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0100000000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 15135 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000000010


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 15345 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0001000000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 15455 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000100000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 15555 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000000010


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 15655 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 1000000000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 16315 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000000010


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 16485 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000000100


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 16585 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 1000000000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../agents/user_agent/user_transaction.sv |Line: 163
Time: 16695 ns | uvm_root              | user_transaction: 
Message: Points accrual error:
Get transaction:
-------------------- Input -------------------
  Client_id     = 48
  item_num      = 3
  Coins in:
  [ 0] 50 RUB
  [ 1] 25 USD
  [ 2] 25 USD
-------------------- Output ------------------
  item_out      = 0000001000
  change_out    = 110
  no_change     = 0
  client_points = 13
  item_empty    = 0000000000
----------------------------------------------

Expected:
-------------------- Input -------------------
  Client_id     = 48
  item_num      = 3
  Coins in:
  [ 0] 50 RUB
  [ 1] 25 USD
  [ 2] 25 USD
-------------------- Output ------------------
  item_out      = 0000001000
  change_out    = 110
  no_change     = 0
  client_points = 10
  item_empty    = 0000000000
----------------------------------------------


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 16975 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000000010


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 17075 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000000001


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 17345 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000000001


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 17575 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000000010


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 17665 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000010000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 17805 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000000100


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 18045 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0001000000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 18135 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000010000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 18265 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0010000000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 18395 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000000001


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 18535 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000000001


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 18655 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000010000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 18785 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000100000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 18965 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000000010


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 19065 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000000001
```

## 4. Artifacts

- Full simulation log: `sim/runs/client_session_without_errors_test_seed_834578/sim_log_client_session_without_errors_test_2.log`
- Waveform file (WLF): `sim/runs/client_session_without_errors_test_seed_834578/vsim_client_session_without_errors_test_2.wlf`
