# [BUG] client_session_after_change_all_registers_test failed with seed 583590

## 1. Environment

- **Test Name:** `client_session_after_change_all_registers_test`
- **Group:** `integration_tests`
- **Seed:** `583590`
- **Git Commit:** `42dfb73`
- **Date/Time:** 11.06.2026 20:20:33

## 2. Steps to Reproduce

```bash
python run_tests.py -t client_session_after_change_all_registers_test -s 583590 -v UVM_LOW --skip_compile
```

> Перезапуск с логами интерфейсов:
>
> ```bash
> python run_tests.py -t client_session_after_change_all_registers_test -s 583590 -v UVM_HIGH --skip_compile
> ```

## 3. Extracted Failures

```text
UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../agents/user_agent/user_transaction.sv |Line: 147
Time: 305 ns | uvm_root              | user_transaction: 
Message: Change issued error:
Get transaction:
-------------------- Input -------------------
  Client_id     = 56
  item_num      = 6
  Coins in:
  [ 0] 25 USD
  [ 1]  1 EUR
  [ 2]  1 USD
  [ 3]  5 EUR
  [ 4] 10 USD
  [ 5] 25 RUB
-------------------- Output ------------------
  item_out      = 0001000000
  change_out    = 62
  no_change     = 0
  client_points = 18
  item_empty    = 0000000000
----------------------------------------------

Expected:
-------------------- Input -------------------
  Client_id     = 56
  item_num      = 6
  Coins in:
  [ 0] 25 USD
  [ 1]  1 EUR
  [ 2]  1 USD
  [ 3]  5 EUR
  [ 4] 10 USD
  [ 5] 25 RUB
-------------------- Output ------------------
  item_out      = 0001000000
  change_out    = 87
  no_change     = 0
  client_points = 17
  item_empty    = 0000000000
----------------------------------------------


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../agents/user_agent/user_transaction.sv |Line: 163
Time: 305 ns | uvm_root              | user_transaction: 
Message: Points accrual error:
Get transaction:
-------------------- Input -------------------
  Client_id     = 56
  item_num      = 6
  Coins in:
  [ 0] 25 USD
  [ 1]  1 EUR
  [ 2]  1 USD
  [ 3]  5 EUR
  [ 4] 10 USD
  [ 5] 25 RUB
-------------------- Output ------------------
  item_out      = 0001000000
  change_out    = 62
  no_change     = 0
  client_points = 18
  item_empty    = 0000000000
----------------------------------------------

Expected:
-------------------- Input -------------------
  Client_id     = 56
  item_num      = 6
  Coins in:
  [ 0] 25 USD
  [ 1]  1 EUR
  [ 2]  1 USD
  [ 3]  5 EUR
  [ 4] 10 USD
  [ 5] 25 RUB
-------------------- Output ------------------
  item_out      = 0001000000
  change_out    = 87
  no_change     = 0
  client_points = 17
  item_empty    = 0000000000
----------------------------------------------


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../agents/user_agent/user_transaction.sv |Line: 147
Time: 575 ns | uvm_root              | user_transaction: 
Message: Change issued error:
Get transaction:
-------------------- Input -------------------
  Client_id     = 51
  item_num      = 4
  Coins in:
  [ 0] 25 RUB  [10]  5 USD
  [ 1]  1 RUB  [11]  1 RUB
  [ 2]  1 EUR  [12]  1 USD
  [ 3] 25 RUB  [13] 10 USD
  [ 4] 10 USD  [14] 10 RUB
  [ 5]  1 EUR  [15] 50 RUB
  [ 6] 50 USD  [16]  1 RUB
  [ 7] 25 USD  [17] 50 RUB
  [ 8]  5 EUR  [18] 25 EUR
  [ 9] 10 RUB
-------------------- Output ------------------
  item_out      = 0000010000
  change_out    = 279
  no_change     = 0
  client_points = 20
  item_empty    = 0000000000
----------------------------------------------

Expected:
-------------------- Input -------------------
  Client_id     = 51
  item_num      = 4
  Coins in:
  [ 0] 25 RUB  [10]  5 USD
  [ 1]  1 RUB  [11]  1 RUB
  [ 2]  1 EUR  [12]  1 USD
  [ 3] 25 RUB  [13] 10 USD
  [ 4] 10 USD  [14] 10 RUB
  [ 5]  1 EUR  [15] 50 RUB
  [ 6] 50 USD  [16]  1 RUB
  [ 7] 25 USD  [17] 50 RUB
  [ 8]  5 EUR  [18] 25 EUR
  [ 9] 10 RUB
-------------------- Output ------------------
  item_out      = 0000010000
  change_out    = 363
  no_change     = 0
  client_points = 16
  item_empty    = 0000000000
----------------------------------------------


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../agents/user_agent/user_transaction.sv |Line: 163
Time: 575 ns | uvm_root              | user_transaction: 
Message: Points accrual error:
Get transaction:
-------------------- Input -------------------
  Client_id     = 51
  item_num      = 4
  Coins in:
  [ 0] 25 RUB  [10]  5 USD
  [ 1]  1 RUB  [11]  1 RUB
  [ 2]  1 EUR  [12]  1 USD
  [ 3] 25 RUB  [13] 10 USD
  [ 4] 10 USD  [14] 10 RUB
  [ 5]  1 EUR  [15] 50 RUB
  [ 6] 50 USD  [16]  1 RUB
  [ 7] 25 USD  [17] 50 RUB
  [ 8]  5 EUR  [18] 25 EUR
  [ 9] 10 RUB
-------------------- Output ------------------
  item_out      = 0000010000
  change_out    = 279
  no_change     = 0
  client_points = 20
  item_empty    = 0000000000
----------------------------------------------

Expected:
-------------------- Input -------------------
  Client_id     = 51
  item_num      = 4
  Coins in:
  [ 0] 25 RUB  [10]  5 USD
  [ 1]  1 RUB  [11]  1 RUB
  [ 2]  1 EUR  [12]  1 USD
  [ 3] 25 RUB  [13] 10 USD
  [ 4] 10 USD  [14] 10 RUB
  [ 5]  1 EUR  [15] 50 RUB
  [ 6] 50 USD  [16]  1 RUB
  [ 7] 25 USD  [17] 50 RUB
  [ 8]  5 EUR  [18] 25 EUR
  [ 9] 10 RUB
-------------------- Output ------------------
  item_out      = 0000010000
  change_out    = 363
  no_change     = 0
  client_points = 16
  item_empty    = 0000000000
----------------------------------------------


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../agents/user_agent/user_transaction.sv |Line: 147
Time: 665 ns | uvm_root              | user_transaction: 
Message: Change issued error:
Get transaction:
-------------------- Input -------------------
  Client_id     = 98
  item_num      = 5
  Coins in:
  [ 0] 50 EUR
-------------------- Output ------------------
  item_out      = 0000100000
  change_out    = 30
  no_change     = 0
  client_points = 24
  item_empty    = 0000000000
----------------------------------------------

Expected:
-------------------- Input -------------------
  Client_id     = 98
  item_num      = 5
  Coins in:
  [ 0] 50 EUR
-------------------- Output ------------------
  item_out      = 0000100000
  change_out    = 120
  no_change     = 0
  client_points = 19
  item_empty    = 0000000000
----------------------------------------------


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../agents/user_agent/user_transaction.sv |Line: 163
Time: 665 ns | uvm_root              | user_transaction: 
Message: Points accrual error:
Get transaction:
-------------------- Input -------------------
  Client_id     = 98
  item_num      = 5
  Coins in:
  [ 0] 50 EUR
-------------------- Output ------------------
  item_out      = 0000100000
  change_out    = 30
  no_change     = 0
  client_points = 24
  item_empty    = 0000000000
----------------------------------------------

Expected:
-------------------- Input -------------------
  Client_id     = 98
  item_num      = 5
  Coins in:
  [ 0] 50 EUR
-------------------- Output ------------------
  item_out      = 0000100000
  change_out    = 120
  no_change     = 0
  client_points = 19
  item_empty    = 0000000000
----------------------------------------------


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../agents/user_agent/user_transaction.sv |Line: 147
Time: 1465 ns | uvm_root              | user_transaction: 
Message: Change issued error:
Get transaction:
-------------------- Input -------------------
  Client_id     = 39
  item_num      = 1
  Coins in:
  [ 0]  1 RUB  [10]  5 RUB  [20] 10 USD  [30] 50 EUR  [40] 25 RUB  [50] 25 RUB  [60] 25 EUR  [70] 50 RUB
  [ 1]  5 USD  [11] 50 RUB  [21] 10 USD  [31]  5 RUB  [41]  5 RUB  [51] 10 EUR  [61]  5 EUR  [71]  5 EUR
  [ 2] 10 RUB  [12] 25 RUB  [22]  5 EUR  [32] 10 USD  [42]  1 RUB  [52] 25 EUR  [62] 25 RUB
  [ 3] 50 USD  [13]  1 EUR  [23] 10 USD  [33] 25 USD  [43] 50 USD  [53] 10 USD  [63] 10 EUR
  [ 4] 50 USD  [14] 10 USD  [24] 10 USD  [34] 50 EUR  [44]  5 EUR  [54] 10 EUR  [64] 25 USD
  [ 5]  5 EUR  [15] 50 EUR  [25] 25 USD  [35]  5 USD  [45] 10 RUB  [55] 50 EUR  [65]  1 EUR
  [ 6] 10 EUR  [16]  5 RUB  [26] 25 USD  [36] 50 EUR  [46]  5 EUR  [56] 10 EUR  [66]  1 RUB
  [ 7] 25 RUB  [17]  1 EUR  [27]  5 RUB  [37] 10 USD  [47] 10 USD  [57] 50 USD  [67] 10 EUR
  [ 8]  5 USD  [18] 10 USD  [28] 50 EUR  [38]  5 RUB  [48] 25 RUB  [58] 25 RUB  [68] 50 USD
  [ 9] 50 EUR  [19] 10 RUB  [29] 10 EUR  [39] 25 RUB  [49] 25 USD  [59] 50 RUB  [69]  1 RUB
-------------------- Output ------------------
  item_out      = 0000000010
  change_out    = 2783
  no_change     = 0
  client_points = 25
  item_empty    = 0000000000
----------------------------------------------

Expected:
-------------------- Input -------------------
  Client_id     = 39
  item_num      = 1
  Coins in:
  [ 0]  1 RUB  [10]  5 RUB  [20] 10 USD  [30] 50 EUR  [40] 25 RUB  [50] 25 RUB  [60] 25 EUR  [70] 50 RUB
  [ 1]  5 USD  [11] 50 RUB  [21] 10 USD  [31]  5 RUB  [41]  5 RUB  [51] 10 EUR  [61]  5 EUR  [71]  5 EUR
  [ 2] 10 RUB  [12] 25 RUB  [22]  5 EUR  [32] 10 USD  [42]  1 RUB  [52] 25 EUR  [62] 25 RUB
  [ 3] 50 USD  [13]  1 EUR  [23] 10 USD  [33] 25 USD  [43] 50 USD  [53] 10 USD  [63] 10 EUR
  [ 4] 50 USD  [14] 10 USD  [24] 10 USD  [34] 50 EUR  [44]  5 EUR  [54] 10 EUR  [64] 25 USD
  [ 5]  5 EUR  [15] 50 EUR  [25] 25 USD  [35]  5 USD  [45] 10 RUB  [55] 50 EUR  [65]  1 EUR
  [ 6] 10 EUR  [16]  5 RUB  [26] 25 USD  [36] 50 EUR  [46]  5 EUR  [56] 10 EUR  [66]  1 RUB
  [ 7] 25 RUB  [17]  1 EUR  [27]  5 RUB  [37] 10 USD  [47] 10 USD  [57] 50 USD  [67] 10 EUR
  [ 8]  5 USD  [18] 10 USD  [28] 50 EUR  [38]  5 RUB  [48] 25 RUB  [58] 25 RUB  [68] 50 USD
  [ 9] 50 EUR  [19] 10 RUB  [29] 10 EUR  [39] 25 RUB  [49] 25 USD  [59] 50 RUB  [69]  1 RUB
-------------------- Output ------------------
  item_out      = 0000000010
  change_out    = 2887
  no_change     = 0
  client_points = 19
  item_empty    = 0000000000
----------------------------------------------


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../agents/user_agent/user_transaction.sv |Line: 163
Time: 1465 ns | uvm_root              | user_transaction: 
Message: Points accrual error:
Get transaction:
-------------------- Input -------------------
  Client_id     = 39
  item_num      = 1
  Coins in:
  [ 0]  1 RUB  [10]  5 RUB  [20] 10 USD  [30] 50 EUR  [40] 25 RUB  [50] 25 RUB  [60] 25 EUR  [70] 50 RUB
  [ 1]  5 USD  [11] 50 RUB  [21] 10 USD  [31]  5 RUB  [41]  5 RUB  [51] 10 EUR  [61]  5 EUR  [71]  5 EUR
  [ 2] 10 RUB  [12] 25 RUB  [22]  5 EUR  [32] 10 USD  [42]  1 RUB  [52] 25 EUR  [62] 25 RUB
  [ 3] 50 USD  [13]  1 EUR  [23] 10 USD  [33] 25 USD  [43] 50 USD  [53] 10 USD  [63] 10 EUR
  [ 4] 50 USD  [14] 10 USD  [24] 10 USD  [34] 50 EUR  [44]  5 EUR  [54] 10 EUR  [64] 25 USD
  [ 5]  5 EUR  [15] 50 EUR  [25] 25 USD  [35]  5 USD  [45] 10 RUB  [55] 50 EUR  [65]  1 EUR
  [ 6] 10 EUR  [16]  5 RUB  [26] 25 USD  [36] 50 EUR  [46]  5 EUR  [56] 10 EUR  [66]  1 RUB
  [ 7] 25 RUB  [17]  1 EUR  [27]  5 RUB  [37] 10 USD  [47] 10 USD  [57] 50 USD  [67] 10 EUR
  [ 8]  5 USD  [18] 10 USD  [28] 50 EUR  [38]  5 RUB  [48] 25 RUB  [58] 25 RUB  [68] 50 USD
  [ 9] 50 EUR  [19] 10 RUB  [29] 10 EUR  [39] 25 RUB  [49] 25 USD  [59] 50 RUB  [69]  1 RUB
-------------------- Output ------------------
  item_out      = 0000000010
  change_out    = 2783
  no_change     = 0
  client_points = 25
  item_empty    = 0000000000
----------------------------------------------

Expected:
-------------------- Input -------------------
  Client_id     = 39
  item_num      = 1
  Coins in:
  [ 0]  1 RUB  [10]  5 RUB  [20] 10 USD  [30] 50 EUR  [40] 25 RUB  [50] 25 RUB  [60] 25 EUR  [70] 50 RUB
  [ 1]  5 USD  [11] 50 RUB  [21] 10 USD  [31]  5 RUB  [41]  5 RUB  [51] 10 EUR  [61]  5 EUR  [71]  5 EUR
  [ 2] 10 RUB  [12] 25 RUB  [22]  5 EUR  [32] 10 USD  [42]  1 RUB  [52] 25 EUR  [62] 25 RUB
  [ 3] 50 USD  [13]  1 EUR  [23] 10 USD  [33] 25 USD  [43] 50 USD  [53] 10 USD  [63] 10 EUR
  [ 4] 50 USD  [14] 10 USD  [24] 10 USD  [34] 50 EUR  [44]  5 EUR  [54] 10 EUR  [64] 25 USD
  [ 5]  5 EUR  [15] 50 EUR  [25] 25 USD  [35]  5 USD  [45] 10 RUB  [55] 50 EUR  [65]  1 EUR
  [ 6] 10 EUR  [16]  5 RUB  [26] 25 USD  [36] 50 EUR  [46]  5 EUR  [56] 10 EUR  [66]  1 RUB
  [ 7] 25 RUB  [17]  1 EUR  [27]  5 RUB  [37] 10 USD  [47] 10 USD  [57] 50 USD  [67] 10 EUR
  [ 8]  5 USD  [18] 10 USD  [28] 50 EUR  [38]  5 RUB  [48] 25 RUB  [58] 25 RUB  [68] 50 USD
  [ 9] 50 EUR  [19] 10 RUB  [29] 10 EUR  [39] 25 RUB  [49] 25 USD  [59] 50 RUB  [69]  1 RUB
-------------------- Output ------------------
  item_out      = 0000000010
  change_out    = 2887
  no_change     = 0
  client_points = 19
  item_empty    = 0000000000
----------------------------------------------


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../agents/user_agent/user_transaction.sv |Line: 147
Time: 1585 ns | uvm_root              | user_transaction: 
Message: Change issued error:
Get transaction:
-------------------- Input -------------------
  Client_id     = 65
  item_num      = 6
  Coins in:
  [ 0] 25 EUR
  [ 1] 10 EUR
  [ 2] 10 USD
  [ 3] 10 RUB
-------------------- Output ------------------
  item_out      = 0001000000
  change_out    = 82
  no_change     = 0
  client_points = 7
  item_empty    = 0000000000
----------------------------------------------

Expected:
-------------------- Input -------------------
  Client_id     = 65
  item_num      = 6
  Coins in:
  [ 0] 25 EUR
  [ 1] 10 EUR
  [ 2] 10 USD
  [ 3] 10 RUB
-------------------- Output ------------------
  item_out      = 0001000000
  change_out    = 107
  no_change     = 0
  client_points = 6
  item_empty    = 0000000000
----------------------------------------------


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../agents/user_agent/user_transaction.sv |Line: 163
Time: 1585 ns | uvm_root              | user_transaction: 
Message: Points accrual error:
Get transaction:
-------------------- Input -------------------
  Client_id     = 65
  item_num      = 6
  Coins in:
  [ 0] 25 EUR
  [ 1] 10 EUR
  [ 2] 10 USD
  [ 3] 10 RUB
-------------------- Output ------------------
  item_out      = 0001000000
  change_out    = 82
  no_change     = 0
  client_points = 7
  item_empty    = 0000000000
----------------------------------------------

Expected:
-------------------- Input -------------------
  Client_id     = 65
  item_num      = 6
  Coins in:
  [ 0] 25 EUR
  [ 1] 10 EUR
  [ 2] 10 USD
  [ 3] 10 RUB
-------------------- Output ------------------
  item_out      = 0001000000
  change_out    = 107
  no_change     = 0
  client_points = 6
  item_empty    = 0000000000
----------------------------------------------


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../agents/user_agent/user_transaction.sv |Line: 147
Time: 1855 ns | uvm_root              | user_transaction: 
Message: Change issued error:
Get transaction:
-------------------- Input -------------------
  Client_id     = 66
  item_num      = 1
  Coins in:
  [ 0] 10 USD  [10]  5 EUR
  [ 1] 10 RUB  [11] 25 RUB
  [ 2] 50 EUR  [12]  5 EUR
  [ 3] 50 RUB  [13]  1 USD
  [ 4]  1 EUR  [14] 25 USD
  [ 5] 10 RUB  [15]  1 RUB
  [ 6]  5 RUB  [16] 25 RUB
  [ 7] 25 EUR  [17]  5 EUR
  [ 8]  1 RUB  [18] 10 USD
  [ 9]  1 USD
-------------------- Output ------------------
  item_out      = 0000000010
  change_out    = 374
  no_change     = 0
  client_points = 12
  item_empty    = 0000000000
----------------------------------------------

Expected:
-------------------- Input -------------------
  Client_id     = 66
  item_num      = 1
  Coins in:
  [ 0] 10 USD  [10]  5 EUR
  [ 1] 10 RUB  [11] 25 RUB
  [ 2] 50 EUR  [12]  5 EUR
  [ 3] 50 RUB  [13]  1 USD
  [ 4]  1 EUR  [14] 25 USD
  [ 5] 10 RUB  [15]  1 RUB
  [ 6]  5 RUB  [16] 25 RUB
  [ 7] 25 EUR  [17]  5 EUR
  [ 8]  1 RUB  [18] 10 USD
  [ 9]  1 USD
-------------------- Output ------------------
  item_out      = 0000000010
  change_out    = 478
  no_change     = 0
  client_points = 6
  item_empty    = 0000000000
----------------------------------------------


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../agents/user_agent/user_transaction.sv |Line: 163
Time: 1855 ns | uvm_root              | user_transaction: 
Message: Points accrual error:
Get transaction:
-------------------- Input -------------------
  Client_id     = 66
  item_num      = 1
  Coins in:
  [ 0] 10 USD  [10]  5 EUR
  [ 1] 10 RUB  [11] 25 RUB
  [ 2] 50 EUR  [12]  5 EUR
  [ 3] 50 RUB  [13]  1 USD
  [ 4]  1 EUR  [14] 25 USD
  [ 5] 10 RUB  [15]  1 RUB
  [ 6]  5 RUB  [16] 25 RUB
  [ 7] 25 EUR  [17]  5 EUR
  [ 8]  1 RUB  [18] 10 USD
  [ 9]  1 USD
-------------------- Output ------------------
  item_out      = 0000000010
  change_out    = 374
  no_change     = 0
  client_points = 12
  item_empty    = 0000000000
----------------------------------------------

Expected:
-------------------- Input -------------------
  Client_id     = 66
  item_num      = 1
  Coins in:
  [ 0] 10 USD  [10]  5 EUR
  [ 1] 10 RUB  [11] 25 RUB
  [ 2] 50 EUR  [12]  5 EUR
  [ 3] 50 RUB  [13]  1 USD
  [ 4]  1 EUR  [14] 25 USD
  [ 5] 10 RUB  [15]  1 RUB
  [ 6]  5 RUB  [16] 25 RUB
  [ 7] 25 EUR  [17]  5 EUR
  [ 8]  1 RUB  [18] 10 USD
  [ 9]  1 USD
-------------------- Output ------------------
  item_out      = 0000000010
  change_out    = 478
  no_change     = 0
  client_points = 6
  item_empty    = 0000000000
----------------------------------------------


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../agents/user_agent/user_transaction.sv |Line: 147
Time: 1995 ns | uvm_root              | user_transaction: 
Message: Change issued error:
Get transaction:
-------------------- Input -------------------
  Client_id     = 1
  item_num      = 2
  Coins in:
  [ 0] 10 RUB
  [ 1]  1 USD
  [ 2] 50 RUB
  [ 3]  5 EUR
  [ 4] 25 USD
  [ 5] 10 RUB
-------------------- Output ------------------
  item_out      = 0000000100
  change_out    = 96
  no_change     = 0
  client_points = 3
  item_empty    = 0000000000
----------------------------------------------

Expected:
-------------------- Input -------------------
  Client_id     = 1
  item_num      = 2
  Coins in:
  [ 0] 10 RUB
  [ 1]  1 USD
  [ 2] 50 RUB
  [ 3]  5 EUR
  [ 4] 25 USD
  [ 5] 10 RUB
-------------------- Output ------------------
  item_out      = 0000000100
  change_out    = 121
  no_change     = 0
  client_points = 1
  item_empty    = 0000000000
----------------------------------------------


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../agents/user_agent/user_transaction.sv |Line: 163
Time: 1995 ns | uvm_root              | user_transaction: 
Message: Points accrual error:
Get transaction:
-------------------- Input -------------------
  Client_id     = 1
  item_num      = 2
  Coins in:
  [ 0] 10 RUB
  [ 1]  1 USD
  [ 2] 50 RUB
  [ 3]  5 EUR
  [ 4] 25 USD
  [ 5] 10 RUB
-------------------- Output ------------------
  item_out      = 0000000100
  change_out    = 96
  no_change     = 0
  client_points = 3
  item_empty    = 0000000000
----------------------------------------------

Expected:
-------------------- Input -------------------
  Client_id     = 1
  item_num      = 2
  Coins in:
  [ 0] 10 RUB
  [ 1]  1 USD
  [ 2] 50 RUB
  [ 3]  5 EUR
  [ 4] 25 USD
  [ 5] 10 RUB
-------------------- Output ------------------
  item_out      = 0000000100
  change_out    = 121
  no_change     = 0
  client_points = 1
  item_empty    = 0000000000
----------------------------------------------


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../agents/user_agent/user_transaction.sv |Line: 147
Time: 2695 ns | uvm_root              | user_transaction: 
Message: Change issued error:
Get transaction:
-------------------- Input -------------------
  Client_id     = 98
  item_num      = 6
  Coins in:
  [ 0]  5 USD  [10] 25 RUB  [20] 50 USD  [30] 10 EUR  [40] 10 EUR  [50] 10 EUR  [60] 25 USD
  [ 1] 50 USD  [11] 25 USD  [21]  1 RUB  [31] 50 RUB  [41] 50 USD  [51] 25 RUB  [61]  1 USD
  [ 2] 25 USD  [12]  1 RUB  [22] 10 EUR  [32]  5 USD  [42] 25 USD  [52] 10 EUR
  [ 3]  5 USD  [13] 10 USD  [23] 50 USD  [33]  5 RUB  [43] 25 EUR  [53] 10 EUR
  [ 4] 25 EUR  [14]  5 EUR  [24]  5 USD  [34] 10 RUB  [44] 10 USD  [54]  1 USD
  [ 5] 10 USD  [15] 50 EUR  [25] 25 USD  [35]  5 USD  [45] 25 USD  [55] 10 USD
  [ 6] 25 EUR  [16] 25 RUB  [26] 25 EUR  [36]  5 EUR  [46] 10 USD  [56]  1 EUR
  [ 7] 25 EUR  [17] 50 RUB  [27] 25 RUB  [37] 25 EUR  [47] 50 RUB  [57] 50 RUB
  [ 8] 10 RUB  [18]  5 USD  [28]  5 USD  [38]  1 RUB  [48]  1 EUR  [58] 25 EUR
  [ 9] 50 EUR  [19] 25 USD  [29] 50 RUB  [39] 10 EUR  [49] 25 RUB  [59] 25 USD
-------------------- Output ------------------
  item_out      = 0001000000
  change_out    = 2395
  no_change     = 0
  client_points = 26
  item_empty    = 0000000000
----------------------------------------------

Expected:
-------------------- Input -------------------
  Client_id     = 98
  item_num      = 6
  Coins in:
  [ 0]  5 USD  [10] 25 RUB  [20] 50 USD  [30] 10 EUR  [40] 10 EUR  [50] 10 EUR  [60] 25 USD
  [ 1] 50 USD  [11] 25 USD  [21]  1 RUB  [31] 50 RUB  [41] 50 USD  [51] 25 RUB  [61]  1 USD
  [ 2] 25 USD  [12]  1 RUB  [22] 10 EUR  [32]  5 USD  [42] 25 USD  [52] 10 EUR
  [ 3]  5 USD  [13] 10 USD  [23] 50 USD  [33]  5 RUB  [43] 25 EUR  [53] 10 EUR
  [ 4] 25 EUR  [14]  5 EUR  [24]  5 USD  [34] 10 RUB  [44] 10 USD  [54]  1 USD
  [ 5] 10 USD  [15] 50 EUR  [25] 25 USD  [35]  5 USD  [45] 25 USD  [55] 10 USD
  [ 6] 25 EUR  [16] 25 RUB  [26] 25 EUR  [36]  5 EUR  [46] 10 USD  [56]  1 EUR
  [ 7] 25 EUR  [17] 50 RUB  [27] 25 RUB  [37] 25 EUR  [47] 50 RUB  [57] 50 RUB
  [ 8] 10 RUB  [18]  5 USD  [28]  5 USD  [38]  1 RUB  [48]  1 EUR  [58] 25 EUR
  [ 9] 50 EUR  [19] 25 USD  [29] 50 RUB  [39] 10 EUR  [49] 25 RUB  [59] 25 USD
-------------------- Output ------------------
  item_out      = 0001000000
  change_out    = 2420
  no_change     = 0
  client_points = 20
  item_empty    = 0000000000
----------------------------------------------


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../agents/user_agent/user_transaction.sv |Line: 163
Time: 2695 ns | uvm_root              | user_transaction: 
Message: Points accrual error:
Get transaction:
-------------------- Input -------------------
  Client_id     = 98
  item_num      = 6
  Coins in:
  [ 0]  5 USD  [10] 25 RUB  [20] 50 USD  [30] 10 EUR  [40] 10 EUR  [50] 10 EUR  [60] 25 USD
  [ 1] 50 USD  [11] 25 USD  [21]  1 RUB  [31] 50 RUB  [41] 50 USD  [51] 25 RUB  [61]  1 USD
  [ 2] 25 USD  [12]  1 RUB  [22] 10 EUR  [32]  5 USD  [42] 25 USD  [52] 10 EUR
  [ 3]  5 USD  [13] 10 USD  [23] 50 USD  [33]  5 RUB  [43] 25 EUR  [53] 10 EUR
  [ 4] 25 EUR  [14]  5 EUR  [24]  5 USD  [34] 10 RUB  [44] 10 USD  [54]  1 USD
  [ 5] 10 USD  [15] 50 EUR  [25] 25 USD  [35]  5 USD  [45] 25 USD  [55] 10 USD
  [ 6] 25 EUR  [16] 25 RUB  [26] 25 EUR  [36]  5 EUR  [46] 10 USD  [56]  1 EUR
  [ 7] 25 EUR  [17] 50 RUB  [27] 25 RUB  [37] 25 EUR  [47] 50 RUB  [57] 50 RUB
  [ 8] 10 RUB  [18]  5 USD  [28]  5 USD  [38]  1 RUB  [48]  1 EUR  [58] 25 EUR
  [ 9] 50 EUR  [19] 25 USD  [29] 50 RUB  [39] 10 EUR  [49] 25 RUB  [59] 25 USD
-------------------- Output ------------------
  item_out      = 0001000000
  change_out    = 2395
  no_change     = 0
  client_points = 26
  item_empty    = 0000000000
----------------------------------------------

Expected:
-------------------- Input -------------------
  Client_id     = 98
  item_num      = 6
  Coins in:
  [ 0]  5 USD  [10] 25 RUB  [20] 50 USD  [30] 10 EUR  [40] 10 EUR  [50] 10 EUR  [60] 25 USD
  [ 1] 50 USD  [11] 25 USD  [21]  1 RUB  [31] 50 RUB  [41] 50 USD  [51] 25 RUB  [61]  1 USD
  [ 2] 25 USD  [12]  1 RUB  [22] 10 EUR  [32]  5 USD  [42] 25 USD  [52] 10 EUR
  [ 3]  5 USD  [13] 10 USD  [23] 50 USD  [33]  5 RUB  [43] 25 EUR  [53] 10 EUR
  [ 4] 25 EUR  [14]  5 EUR  [24]  5 USD  [34] 10 RUB  [44] 10 USD  [54]  1 USD
  [ 5] 10 USD  [15] 50 EUR  [25] 25 USD  [35]  5 USD  [45] 25 USD  [55] 10 USD
  [ 6] 25 EUR  [16] 25 RUB  [26] 25 EUR  [36]  5 EUR  [46] 10 USD  [56]  1 EUR
  [ 7] 25 EUR  [17] 50 RUB  [27] 25 RUB  [37] 25 EUR  [47] 50 RUB  [57] 50 RUB
  [ 8] 10 RUB  [18]  5 USD  [28]  5 USD  [38]  1 RUB  [48]  1 EUR  [58] 25 EUR
  [ 9] 50 EUR  [19] 25 USD  [29] 50 RUB  [39] 10 EUR  [49] 25 RUB  [59] 25 USD
-------------------- Output ------------------
  item_out      = 0001000000
  change_out    = 2420
  no_change     = 0
  client_points = 20
  item_empty    = 0000000000
----------------------------------------------


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../agents/user_agent/user_transaction.sv |Line: 147
Time: 2815 ns | uvm_root              | user_transaction: 
Message: Change issued error:
Get transaction:
-------------------- Input -------------------
  Client_id     = 50
  item_num      = 9
  Coins in:
  [ 0] 50 RUB
  [ 1]  5 USD
  [ 2] 50 USD
  [ 3] 10 RUB
-------------------- Output ------------------
  item_out      = 1000000000
  change_out    = 83
  no_change     = 0
  client_points = 14
  item_empty    = 0000000000
----------------------------------------------

Expected:
-------------------- Input -------------------
  Client_id     = 50
  item_num      = 9
  Coins in:
  [ 0] 50 RUB
  [ 1]  5 USD
  [ 2] 50 USD
  [ 3] 10 RUB
-------------------- Output ------------------
  item_out      = 1000000000
  change_out    = 84
  no_change     = 0
  client_points = 14
  item_empty    = 0000000000
----------------------------------------------


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../agents/user_agent/user_transaction.sv |Line: 147
Time: 2955 ns | uvm_root              | user_transaction: 
Message: Change issued error:
Get transaction:
-------------------- Input -------------------
  Client_id     = 7
  item_num      = 3
  Coins in:
  [ 0]  5 USD
  [ 1] 50 USD
  [ 2] 10 RUB
  [ 3]  5 USD
  [ 4] 50 RUB
  [ 5] 10 USD
-------------------- Output ------------------
  item_out      = 0000001000
  change_out    = 117
  no_change     = 0
  client_points = 11
  item_empty    = 0000000000
----------------------------------------------

Expected:
-------------------- Input -------------------
  Client_id     = 7
  item_num      = 3
  Coins in:
  [ 0]  5 USD
  [ 1] 50 USD
  [ 2] 10 RUB
  [ 3]  5 USD
  [ 4] 50 RUB
  [ 5] 10 USD
-------------------- Output ------------------
  item_out      = 0000001000
  change_out    = 165
  no_change     = 0
  client_points = 8
  item_empty    = 0000000000
----------------------------------------------


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../agents/user_agent/user_transaction.sv |Line: 163
Time: 2955 ns | uvm_root              | user_transaction: 
Message: Points accrual error:
Get transaction:
-------------------- Input -------------------
  Client_id     = 7
  item_num      = 3
  Coins in:
  [ 0]  5 USD
  [ 1] 50 USD
  [ 2] 10 RUB
  [ 3]  5 USD
  [ 4] 50 RUB
  [ 5] 10 USD
-------------------- Output ------------------
  item_out      = 0000001000
  change_out    = 117
  no_change     = 0
  client_points = 11
  item_empty    = 0000000000
----------------------------------------------

Expected:
-------------------- Input -------------------
  Client_id     = 7
  item_num      = 3
  Coins in:
  [ 0]  5 USD
  [ 1] 50 USD
  [ 2] 10 RUB
  [ 3]  5 USD
  [ 4] 50 RUB
  [ 5] 10 USD
-------------------- Output ------------------
  item_out      = 0000001000
  change_out    = 165
  no_change     = 0
  client_points = 8
  item_empty    = 0000000000
----------------------------------------------
```

## 4. Artifacts

- Full simulation log: `sim/runs/client_session_after_change_all_registers_test_seed_583590/sim_log_client_session_after_change_all_registers_test_1.log`
- Waveform file (WLF): `sim/runs/client_session_after_change_all_registers_test_seed_583590/vsim_client_session_after_change_all_registers_test_1.wlf`
