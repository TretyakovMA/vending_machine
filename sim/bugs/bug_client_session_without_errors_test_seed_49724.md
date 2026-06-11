# [BUG] client_session_without_errors_test failed with seed 49724

## 1. Environment

- **Test Name:** `client_session_without_errors_test`
- **Group:** `user_tests`
- **Seed:** `49724`
- **Git Commit:** `42dfb73`
- **Date/Time:** 11.06.2026 20:16:58

## 2. Steps to Reproduce

```bash
python run_tests.py -t client_session_without_errors_test -s 49724 -v UVM_LOW --skip_compile
```

> Перезапуск с логами интерфейсов:
>
> ```bash
> python run_tests.py -t client_session_without_errors_test -s 49724 -v UVM_HIGH --skip_compile
> ```

## 3. Extracted Failures

```text
UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 6815 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0100000000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 7305 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000001000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 7405 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000010000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 7525 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0001000000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 7845 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000000001


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 8075 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0100000000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 8315 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0100000000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 8465 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000001000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 8965 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0001000000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 9645 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0001000000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 9845 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000010000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 9955 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000000001


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 10155 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000000001


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 10425 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 1000000000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 10655 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000010000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 10935 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000010000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 11355 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 1000000000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 11665 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000000010


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 11785 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 1000000000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 11925 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000010000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 12055 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0001000000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../agents/user_agent/user_transaction.sv |Line: 163
Time: 12375 ns | uvm_root              | user_transaction: 
Message: Points accrual error:
Get transaction:
-------------------- Input -------------------
  Client_id     = 94
  item_num      = 7
  Coins in:
  [ 0] 25 RUB  [10] 10 RUB  [20]  1 USD
  [ 1]  1 RUB  [11]  5 EUR  [21]  1 EUR
  [ 2] 50 EUR  [12] 10 EUR  [22]  5 RUB
  [ 3] 10 EUR  [13] 25 USD  [23] 25 USD
  [ 4] 10 RUB  [14] 25 EUR
  [ 5] 50 RUB  [15] 25 EUR
  [ 6]  1 USD  [16] 50 EUR
  [ 7] 25 RUB  [17] 10 USD
  [ 8]  1 RUB  [18]  1 USD
  [ 9]  1 EUR  [19] 10 USD
-------------------- Output ------------------
  item_out      = 0010000000
  change_out    = 732
  no_change     = 0
  client_points = 19
  item_empty    = 0000000000
----------------------------------------------

Expected:
-------------------- Input -------------------
  Client_id     = 94
  item_num      = 7
  Coins in:
  [ 0] 25 RUB  [10] 10 RUB  [20]  1 USD
  [ 1]  1 RUB  [11]  5 EUR  [21]  1 EUR
  [ 2] 50 EUR  [12] 10 EUR  [22]  5 RUB
  [ 3] 10 EUR  [13] 25 USD  [23] 25 USD
  [ 4] 10 RUB  [14] 25 EUR
  [ 5] 50 RUB  [15] 25 EUR
  [ 6]  1 USD  [16] 50 EUR
  [ 7] 25 RUB  [17] 10 USD
  [ 8]  1 RUB  [18]  1 USD
  [ 9]  1 EUR  [19] 10 USD
-------------------- Output ------------------
  item_out      = 0010000000
  change_out    = 732
  no_change     = 0
  client_points = 17
  item_empty    = 0000000000
----------------------------------------------


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 12515 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0001000000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 12635 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000000010


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 12835 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0100000000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 12985 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000000010


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 13125 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000000001


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 13235 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000010000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 13405 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000001000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 13745 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000000100


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 13875 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000000001


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 14005 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0010000000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../agents/user_agent/user_transaction.sv |Line: 163
Time: 14205 ns | uvm_root              | user_transaction: 
Message: Points accrual error:
Get transaction:
-------------------- Input -------------------
  Client_id     = 78
  item_num      = 5
  Coins in:
  [ 0] 10 EUR  [10] 25 USD
  [ 1] 50 USD  [11] 50 USD
  [ 2]  5 EUR
  [ 3] 10 EUR
  [ 4] 25 EUR
  [ 5] 10 EUR
  [ 6]  1 EUR
  [ 7] 50 RUB
  [ 8] 25 EUR
  [ 9]  1 EUR
-------------------- Output ------------------
  item_out      = 0000100000
  change_out    = 501
  no_change     = 0
  client_points = 22
  item_empty    = 0000000000
----------------------------------------------

Expected:
-------------------- Input -------------------
  Client_id     = 78
  item_num      = 5
  Coins in:
  [ 0] 10 EUR  [10] 25 USD
  [ 1] 50 USD  [11] 50 USD
  [ 2]  5 EUR
  [ 3] 10 EUR
  [ 4] 25 EUR
  [ 5] 10 EUR
  [ 6]  1 EUR
  [ 7] 50 RUB
  [ 8] 25 EUR
  [ 9]  1 EUR
-------------------- Output ------------------
  item_out      = 0000100000
  change_out    = 501
  no_change     = 0
  client_points = 21
  item_empty    = 0000000000
----------------------------------------------


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 14385 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 1000000000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 14625 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000000010


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 14765 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000000010


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 14955 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0001000000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 15055 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000000100


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 15215 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000001000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 15475 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000100000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 15605 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000000010


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 15715 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0001000000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 15845 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000010000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 15955 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000000010


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 16095 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000000100


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 16235 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0001000000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 16365 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000000100


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 16535 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000000010


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 16695 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 1000000000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 16975 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000000100


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 17255 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000000001


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 304
Time: 17885 ns | vm_scoreboard         | vm_scoreboard: 
Message: The item_empty signal is incorrect; should be: 0000000001
```

## 4. Artifacts

- Full simulation log: `sim/runs/client_session_without_errors_test_seed_49724/sim_log_client_session_without_errors_test_1.log`
- Waveform file (WLF): `sim/runs/client_session_without_errors_test_seed_49724/vsim_client_session_without_errors_test_1.wlf`
