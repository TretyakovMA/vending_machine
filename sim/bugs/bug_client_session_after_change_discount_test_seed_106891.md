# [BUG] client_session_after_change_discount_test failed with seed 106891

## 1. Environment

- **Test Name:** `client_session_after_change_discount_test`
- **Group:** `integration_tests`
- **Seed:** `106891`
- **Git Commit:** `42dfb73`
- **Date/Time:** 11.06.2026 20:19:16

## 2. Steps to Reproduce

```bash
python run_tests.py -t client_session_after_change_discount_test -s 106891 -v UVM_LOW --skip_compile
```

> Перезапуск с логами интерфейсов:
>
> ```bash
> python run_tests.py -t client_session_after_change_discount_test -s 106891 -v UVM_HIGH --skip_compile
> ```

## 3. Extracted Failures

```text
UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../agents/user_agent/user_transaction.sv |Line: 147
Time: 235 ns | uvm_root              | user_transaction: 
Message: Change issued error:
Get transaction:
-------------------- Input -------------------
  Client_id     = 49
  item_num      = 0
  Coins in:
  [ 0] 50 USD
  [ 1]  5 RUB
-------------------- Output ------------------
  item_out      = 0000000001
  change_out    = 96
  no_change     = 0
  client_points = 9
  item_empty    = 0000000000
----------------------------------------------

Expected:
-------------------- Input -------------------
  Client_id     = 49
  item_num      = 0
  Coins in:
  [ 0] 50 USD
  [ 1]  5 RUB
-------------------- Output ------------------
  item_out      = 0000000001
  change_out    = 111
  no_change     = 0
  client_points = 8
  item_empty    = 0000000000
----------------------------------------------


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../agents/user_agent/user_transaction.sv |Line: 163
Time: 235 ns | uvm_root              | user_transaction: 
Message: Points accrual error:
Get transaction:
-------------------- Input -------------------
  Client_id     = 49
  item_num      = 0
  Coins in:
  [ 0] 50 USD
  [ 1]  5 RUB
-------------------- Output ------------------
  item_out      = 0000000001
  change_out    = 96
  no_change     = 0
  client_points = 9
  item_empty    = 0000000000
----------------------------------------------

Expected:
-------------------- Input -------------------
  Client_id     = 49
  item_num      = 0
  Coins in:
  [ 0] 50 USD
  [ 1]  5 RUB
-------------------- Output ------------------
  item_out      = 0000000001
  change_out    = 111
  no_change     = 0
  client_points = 8
  item_empty    = 0000000000
----------------------------------------------


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../agents/user_agent/user_transaction.sv |Line: 147
Time: 355 ns | uvm_root              | user_transaction: 
Message: Change issued error:
Get transaction:
-------------------- Input -------------------
  Client_id     = 2
  item_num      = 8
  Coins in:
  [ 0] 10 USD
  [ 1] 50 EUR
  [ 2]  5 USD
  [ 3] 10 EUR
-------------------- Output ------------------
  item_out      = 0100000000
  change_out    = 138
  no_change     = 0
  client_points = 5
  item_empty    = 0000000000
----------------------------------------------

Expected:
-------------------- Input -------------------
  Client_id     = 2
  item_num      = 8
  Coins in:
  [ 0] 10 USD
  [ 1] 50 EUR
  [ 2]  5 USD
  [ 3] 10 EUR
-------------------- Output ------------------
  item_out      = 0100000000
  change_out    = 186
  no_change     = 0
  client_points = 3
  item_empty    = 0000000000
----------------------------------------------


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../agents/user_agent/user_transaction.sv |Line: 163
Time: 355 ns | uvm_root              | user_transaction: 
Message: Points accrual error:
Get transaction:
-------------------- Input -------------------
  Client_id     = 2
  item_num      = 8
  Coins in:
  [ 0] 10 USD
  [ 1] 50 EUR
  [ 2]  5 USD
  [ 3] 10 EUR
-------------------- Output ------------------
  item_out      = 0100000000
  change_out    = 138
  no_change     = 0
  client_points = 5
  item_empty    = 0000000000
----------------------------------------------

Expected:
-------------------- Input -------------------
  Client_id     = 2
  item_num      = 8
  Coins in:
  [ 0] 10 USD
  [ 1] 50 EUR
  [ 2]  5 USD
  [ 3] 10 EUR
-------------------- Output ------------------
  item_out      = 0100000000
  change_out    = 186
  no_change     = 0
  client_points = 3
  item_empty    = 0000000000
----------------------------------------------


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../agents/user_agent/user_transaction.sv |Line: 147
Time: 505 ns | uvm_root              | user_transaction: 
Message: Change issued error:
Get transaction:
-------------------- Input -------------------
  Client_id     = 49
  item_num      = 5
  Coins in:
  [ 0] 10 RUB
  [ 1] 50 USD
  [ 2] 50 RUB
  [ 3] 50 RUB
  [ 4] 10 EUR
  [ 5] 10 RUB
  [ 6]  1 USD
-------------------- Output ------------------
  item_out      = 0000100000
  change_out    = 198
  no_change     = 0
  client_points = 11
  item_empty    = 0000000000
----------------------------------------------

Expected:
-------------------- Input -------------------
  Client_id     = 49
  item_num      = 5
  Coins in:
  [ 0] 10 RUB
  [ 1] 50 USD
  [ 2] 50 RUB
  [ 3] 50 RUB
  [ 4] 10 EUR
  [ 5] 10 RUB
  [ 6]  1 USD
-------------------- Output ------------------
  item_out      = 0000100000
  change_out    = 252
  no_change     = 0
  client_points = 8
  item_empty    = 0000000000
----------------------------------------------


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../agents/user_agent/user_transaction.sv |Line: 163
Time: 505 ns | uvm_root              | user_transaction: 
Message: Points accrual error:
Get transaction:
-------------------- Input -------------------
  Client_id     = 49
  item_num      = 5
  Coins in:
  [ 0] 10 RUB
  [ 1] 50 USD
  [ 2] 50 RUB
  [ 3] 50 RUB
  [ 4] 10 EUR
  [ 5] 10 RUB
  [ 6]  1 USD
-------------------- Output ------------------
  item_out      = 0000100000
  change_out    = 198
  no_change     = 0
  client_points = 11
  item_empty    = 0000000000
----------------------------------------------

Expected:
-------------------- Input -------------------
  Client_id     = 49
  item_num      = 5
  Coins in:
  [ 0] 10 RUB
  [ 1] 50 USD
  [ 2] 50 RUB
  [ 3] 50 RUB
  [ 4] 10 EUR
  [ 5] 10 RUB
  [ 6]  1 USD
-------------------- Output ------------------
  item_out      = 0000100000
  change_out    = 252
  no_change     = 0
  client_points = 8
  item_empty    = 0000000000
----------------------------------------------


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../agents/user_agent/user_transaction.sv |Line: 147
Time: 615 ns | uvm_root              | user_transaction: 
Message: Change issued error:
Get transaction:
-------------------- Input -------------------
  Client_id     = 92
  item_num      = 2
  Coins in:
  [ 0] 10 USD
  [ 1] 10 RUB
  [ 2] 50 USD
-------------------- Output ------------------
  item_out      = 0000000100
  change_out    = 106
  no_change     = 0
  client_points = 13
  item_empty    = 0000000000
----------------------------------------------

Expected:
-------------------- Input -------------------
  Client_id     = 92
  item_num      = 2
  Coins in:
  [ 0] 10 USD
  [ 1] 10 RUB
  [ 2] 50 USD
-------------------- Output ------------------
  item_out      = 0000000100
  change_out    = 118
  no_change     = 0
  client_points = 12
  item_empty    = 0000000000
----------------------------------------------


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../agents/user_agent/user_transaction.sv |Line: 163
Time: 615 ns | uvm_root              | user_transaction: 
Message: Points accrual error:
Get transaction:
-------------------- Input -------------------
  Client_id     = 92
  item_num      = 2
  Coins in:
  [ 0] 10 USD
  [ 1] 10 RUB
  [ 2] 50 USD
-------------------- Output ------------------
  item_out      = 0000000100
  change_out    = 106
  no_change     = 0
  client_points = 13
  item_empty    = 0000000000
----------------------------------------------

Expected:
-------------------- Input -------------------
  Client_id     = 92
  item_num      = 2
  Coins in:
  [ 0] 10 USD
  [ 1] 10 RUB
  [ 2] 50 USD
-------------------- Output ------------------
  item_out      = 0000000100
  change_out    = 118
  no_change     = 0
  client_points = 12
  item_empty    = 0000000000
----------------------------------------------


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../agents/user_agent/user_transaction.sv |Line: 147
Time: 835 ns | uvm_root              | user_transaction: 
Message: Change issued error:
Get transaction:
-------------------- Input -------------------
  Client_id     = 64
  item_num      = 9
  Coins in:
  [ 0] 50 EUR  [10] 50 EUR
  [ 1] 25 RUB  [11]  1 EUR
  [ 2]  5 EUR  [12] 50 USD
  [ 3] 50 RUB  [13] 25 USD
  [ 4]  1 USD
  [ 5] 25 EUR
  [ 6] 25 RUB
  [ 7] 50 USD
  [ 8] 50 USD
  [ 9]  1 EUR
-------------------- Output ------------------
  item_out      = 1000000000
  change_out    = 758
  no_change     = 0
  client_points = 8
  item_empty    = 0000000000
----------------------------------------------

Expected:
-------------------- Input -------------------
  Client_id     = 64
  item_num      = 9
  Coins in:
  [ 0] 50 EUR  [10] 50 EUR
  [ 1] 25 RUB  [11]  1 EUR
  [ 2]  5 EUR  [12] 50 USD
  [ 3] 50 RUB  [13] 25 USD
  [ 4]  1 USD
  [ 5] 25 EUR
  [ 6] 25 RUB
  [ 7] 50 USD
  [ 8] 50 USD
  [ 9]  1 EUR
-------------------- Output ------------------
  item_out      = 1000000000
  change_out    = 798
  no_change     = 0
  client_points = 6
  item_empty    = 0000000000
----------------------------------------------


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../agents/user_agent/user_transaction.sv |Line: 163
Time: 835 ns | uvm_root              | user_transaction: 
Message: Points accrual error:
Get transaction:
-------------------- Input -------------------
  Client_id     = 64
  item_num      = 9
  Coins in:
  [ 0] 50 EUR  [10] 50 EUR
  [ 1] 25 RUB  [11]  1 EUR
  [ 2]  5 EUR  [12] 50 USD
  [ 3] 50 RUB  [13] 25 USD
  [ 4]  1 USD
  [ 5] 25 EUR
  [ 6] 25 RUB
  [ 7] 50 USD
  [ 8] 50 USD
  [ 9]  1 EUR
-------------------- Output ------------------
  item_out      = 1000000000
  change_out    = 758
  no_change     = 0
  client_points = 8
  item_empty    = 0000000000
----------------------------------------------

Expected:
-------------------- Input -------------------
  Client_id     = 64
  item_num      = 9
  Coins in:
  [ 0] 50 EUR  [10] 50 EUR
  [ 1] 25 RUB  [11]  1 EUR
  [ 2]  5 EUR  [12] 50 USD
  [ 3] 50 RUB  [13] 25 USD
  [ 4]  1 USD
  [ 5] 25 EUR
  [ 6] 25 RUB
  [ 7] 50 USD
  [ 8] 50 USD
  [ 9]  1 EUR
-------------------- Output ------------------
  item_out      = 1000000000
  change_out    = 798
  no_change     = 0
  client_points = 6
  item_empty    = 0000000000
----------------------------------------------


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../agents/user_agent/user_transaction.sv |Line: 163
Time: 975 ns | uvm_root              | user_transaction: 
Message: Points accrual error:
Get transaction:
-------------------- Input -------------------
  Client_id     = 2
  item_num      = 4
  Coins in:
  [ 0] 50 USD
  [ 1] 10 EUR
  [ 2] 25 RUB
  [ 3] 50 RUB
  [ 4] 10 RUB
  [ 5]  1 USD
-------------------- Output ------------------
  item_out      = 0000010000
  change_out    = 177
  no_change     = 0
  client_points = 7
  item_empty    = 0000000000
----------------------------------------------

Expected:
-------------------- Input -------------------
  Client_id     = 2
  item_num      = 4
  Coins in:
  [ 0] 50 USD
  [ 1] 10 EUR
  [ 2] 25 RUB
  [ 3] 50 RUB
  [ 4] 10 RUB
  [ 5]  1 USD
-------------------- Output ------------------
  item_out      = 0000010000
  change_out    = 177
  no_change     = 0
  client_points = 5
  item_empty    = 0000000000
----------------------------------------------


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../agents/user_agent/user_transaction.sv |Line: 147
Time: 1765 ns | uvm_root              | user_transaction: 
Message: Change issued error:
Get transaction:
-------------------- Input -------------------
  Client_id     = 89
  item_num      = 0
  Coins in:
  [ 0] 25 RUB  [10] 25 RUB  [20] 10 EUR  [30] 10 RUB  [40] 25 USD  [50] 10 EUR  [60] 25 USD  [70] 10 EUR
  [ 1] 25 RUB  [11] 25 USD  [21] 25 RUB  [31] 10 RUB  [41]  5 RUB  [51] 25 RUB  [61]  5 USD
  [ 2] 25 USD  [12]  1 RUB  [22]  1 RUB  [32]  5 RUB  [42] 25 EUR  [52]  5 EUR  [62] 10 USD
  [ 3] 25 RUB  [13] 50 EUR  [23] 50 RUB  [33] 50 RUB  [43] 25 RUB  [53]  1 RUB  [63] 50 USD
  [ 4] 50 USD  [14] 50 EUR  [24]  5 EUR  [34]  5 EUR  [44] 25 RUB  [54] 25 EUR  [64]  1 RUB
  [ 5] 25 RUB  [15] 50 EUR  [25] 25 USD  [35]  5 EUR  [45] 50 USD  [55] 10 RUB  [65]  5 USD
  [ 6]  5 RUB  [16] 25 RUB  [26] 25 EUR  [36] 50 EUR  [46]  1 EUR  [56] 25 EUR  [66] 50 USD
  [ 7]  1 EUR  [17] 50 EUR  [27]  5 RUB  [37]  5 RUB  [47] 10 EUR  [57] 25 EUR  [67] 25 RUB
  [ 8]  1 RUB  [18] 50 EUR  [28] 10 RUB  [38]  5 RUB  [48] 50 RUB  [58] 25 RUB  [68] 25 USD
  [ 9] 10 USD  [19] 25 RUB  [29]  1 USD  [39]  1 USD  [49] 10 USD  [59] 50 USD  [69]  5 EUR
-------------------- Output ------------------
  item_out      = 0000000001
  change_out    = 2902
  no_change     = 0
  client_points = 9
  item_empty    = 0000000000
----------------------------------------------

Expected:
-------------------- Input -------------------
  Client_id     = 89
  item_num      = 0
  Coins in:
  [ 0] 25 RUB  [10] 25 RUB  [20] 10 EUR  [30] 10 RUB  [40] 25 USD  [50] 10 EUR  [60] 25 USD  [70] 10 EUR
  [ 1] 25 RUB  [11] 25 USD  [21] 25 RUB  [31] 10 RUB  [41]  5 RUB  [51] 25 RUB  [61]  5 USD
  [ 2] 25 USD  [12]  1 RUB  [22]  1 RUB  [32]  5 RUB  [42] 25 EUR  [52]  5 EUR  [62] 10 USD
  [ 3] 25 RUB  [13] 50 EUR  [23] 50 RUB  [33] 50 RUB  [43] 25 RUB  [53]  1 RUB  [63] 50 USD
  [ 4] 50 USD  [14] 50 EUR  [24]  5 EUR  [34]  5 EUR  [44] 25 RUB  [54] 25 EUR  [64]  1 RUB
  [ 5] 25 RUB  [15] 50 EUR  [25] 25 USD  [35]  5 EUR  [45] 50 USD  [55] 10 RUB  [65]  5 USD
  [ 6]  5 RUB  [16] 25 RUB  [26] 25 EUR  [36] 50 EUR  [46]  1 EUR  [56] 25 EUR  [66] 50 USD
  [ 7]  1 EUR  [17] 50 EUR  [27]  5 RUB  [37]  5 RUB  [47] 10 EUR  [57] 25 EUR  [67] 25 RUB
  [ 8]  1 RUB  [18] 50 EUR  [28] 10 RUB  [38]  5 RUB  [48] 50 RUB  [58] 25 RUB  [68] 25 USD
  [ 9] 10 USD  [19] 25 RUB  [29]  1 USD  [39]  1 USD  [49] 10 USD  [59] 50 USD  [69]  5 EUR
-------------------- Output ------------------
  item_out      = 0000000001
  change_out    = 2915
  no_change     = 0
  client_points = 8
  item_empty    = 0000000000
----------------------------------------------


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../agents/user_agent/user_transaction.sv |Line: 163
Time: 1765 ns | uvm_root              | user_transaction: 
Message: Points accrual error:
Get transaction:
-------------------- Input -------------------
  Client_id     = 89
  item_num      = 0
  Coins in:
  [ 0] 25 RUB  [10] 25 RUB  [20] 10 EUR  [30] 10 RUB  [40] 25 USD  [50] 10 EUR  [60] 25 USD  [70] 10 EUR
  [ 1] 25 RUB  [11] 25 USD  [21] 25 RUB  [31] 10 RUB  [41]  5 RUB  [51] 25 RUB  [61]  5 USD
  [ 2] 25 USD  [12]  1 RUB  [22]  1 RUB  [32]  5 RUB  [42] 25 EUR  [52]  5 EUR  [62] 10 USD
  [ 3] 25 RUB  [13] 50 EUR  [23] 50 RUB  [33] 50 RUB  [43] 25 RUB  [53]  1 RUB  [63] 50 USD
  [ 4] 50 USD  [14] 50 EUR  [24]  5 EUR  [34]  5 EUR  [44] 25 RUB  [54] 25 EUR  [64]  1 RUB
  [ 5] 25 RUB  [15] 50 EUR  [25] 25 USD  [35]  5 EUR  [45] 50 USD  [55] 10 RUB  [65]  5 USD
  [ 6]  5 RUB  [16] 25 RUB  [26] 25 EUR  [36] 50 EUR  [46]  1 EUR  [56] 25 EUR  [66] 50 USD
  [ 7]  1 EUR  [17] 50 EUR  [27]  5 RUB  [37]  5 RUB  [47] 10 EUR  [57] 25 EUR  [67] 25 RUB
  [ 8]  1 RUB  [18] 50 EUR  [28] 10 RUB  [38]  5 RUB  [48] 50 RUB  [58] 25 RUB  [68] 25 USD
  [ 9] 10 USD  [19] 25 RUB  [29]  1 USD  [39]  1 USD  [49] 10 USD  [59] 50 USD  [69]  5 EUR
-------------------- Output ------------------
  item_out      = 0000000001
  change_out    = 2902
  no_change     = 0
  client_points = 9
  item_empty    = 0000000000
----------------------------------------------

Expected:
-------------------- Input -------------------
  Client_id     = 89
  item_num      = 0
  Coins in:
  [ 0] 25 RUB  [10] 25 RUB  [20] 10 EUR  [30] 10 RUB  [40] 25 USD  [50] 10 EUR  [60] 25 USD  [70] 10 EUR
  [ 1] 25 RUB  [11] 25 USD  [21] 25 RUB  [31] 10 RUB  [41]  5 RUB  [51] 25 RUB  [61]  5 USD
  [ 2] 25 USD  [12]  1 RUB  [22]  1 RUB  [32]  5 RUB  [42] 25 EUR  [52]  5 EUR  [62] 10 USD
  [ 3] 25 RUB  [13] 50 EUR  [23] 50 RUB  [33] 50 RUB  [43] 25 RUB  [53]  1 RUB  [63] 50 USD
  [ 4] 50 USD  [14] 50 EUR  [24]  5 EUR  [34]  5 EUR  [44] 25 RUB  [54] 25 EUR  [64]  1 RUB
  [ 5] 25 RUB  [15] 50 EUR  [25] 25 USD  [35]  5 EUR  [45] 50 USD  [55] 10 RUB  [65]  5 USD
  [ 6]  5 RUB  [16] 25 RUB  [26] 25 EUR  [36] 50 EUR  [46]  1 EUR  [56] 25 EUR  [66] 50 USD
  [ 7]  1 EUR  [17] 50 EUR  [27]  5 RUB  [37]  5 RUB  [47] 10 EUR  [57] 25 EUR  [67] 25 RUB
  [ 8]  1 RUB  [18] 50 EUR  [28] 10 RUB  [38]  5 RUB  [48] 50 RUB  [58] 25 RUB  [68] 25 USD
  [ 9] 10 USD  [19] 25 RUB  [29]  1 USD  [39]  1 USD  [49] 10 USD  [59] 50 USD  [69]  5 EUR
-------------------- Output ------------------
  item_out      = 0000000001
  change_out    = 2915
  no_change     = 0
  client_points = 8
  item_empty    = 0000000000
----------------------------------------------


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../agents/user_agent/user_transaction.sv |Line: 147
Time: 1895 ns | uvm_root              | user_transaction: 
Message: Change issued error:
Get transaction:
-------------------- Input -------------------
  Client_id     = 61
  item_num      = 8
  Coins in:
  [ 0] 50 EUR
  [ 1] 50 EUR
  [ 2] 25 USD
  [ 3]  1 USD
  [ 4] 10 EUR
-------------------- Output ------------------
  item_out      = 0100000000
  change_out    = 301
  no_change     = 0
  client_points = 5
  item_empty    = 0000000000
----------------------------------------------

Expected:
-------------------- Input -------------------
  Client_id     = 61
  item_num      = 8
  Coins in:
  [ 0] 50 EUR
  [ 1] 50 EUR
  [ 2] 25 USD
  [ 3]  1 USD
  [ 4] 10 EUR
-------------------- Output ------------------
  item_out      = 0100000000
  change_out    = 355
  no_change     = 0
  client_points = 2
  item_empty    = 0000000000
----------------------------------------------


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../agents/user_agent/user_transaction.sv |Line: 163
Time: 1895 ns | uvm_root              | user_transaction: 
Message: Points accrual error:
Get transaction:
-------------------- Input -------------------
  Client_id     = 61
  item_num      = 8
  Coins in:
  [ 0] 50 EUR
  [ 1] 50 EUR
  [ 2] 25 USD
  [ 3]  1 USD
  [ 4] 10 EUR
-------------------- Output ------------------
  item_out      = 0100000000
  change_out    = 301
  no_change     = 0
  client_points = 5
  item_empty    = 0000000000
----------------------------------------------

Expected:
-------------------- Input -------------------
  Client_id     = 61
  item_num      = 8
  Coins in:
  [ 0] 50 EUR
  [ 1] 50 EUR
  [ 2] 25 USD
  [ 3]  1 USD
  [ 4] 10 EUR
-------------------- Output ------------------
  item_out      = 0100000000
  change_out    = 355
  no_change     = 0
  client_points = 2
  item_empty    = 0000000000
----------------------------------------------


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../agents/user_agent/user_transaction.sv |Line: 147
Time: 2025 ns | uvm_root              | user_transaction: 
Message: Change issued error:
Get transaction:
-------------------- Input -------------------
  Client_id     = 86
  item_num      = 0
  Coins in:
  [ 0] 25 RUB
  [ 1] 50 RUB
  [ 2] 25 EUR
  [ 3]  5 USD
  [ 4] 50 USD
-------------------- Output ------------------
  item_out      = 0000000001
  change_out    = 252
  no_change     = 0
  client_points = 6
  item_empty    = 0000000000
----------------------------------------------

Expected:
-------------------- Input -------------------
  Client_id     = 86
  item_num      = 0
  Coins in:
  [ 0] 25 RUB
  [ 1] 50 RUB
  [ 2] 25 EUR
  [ 3]  5 USD
  [ 4] 50 USD
-------------------- Output ------------------
  item_out      = 0000000001
  change_out    = 265
  no_change     = 0
  client_points = 5
  item_empty    = 0000000000
----------------------------------------------


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../agents/user_agent/user_transaction.sv |Line: 163
Time: 2025 ns | uvm_root              | user_transaction: 
Message: Points accrual error:
Get transaction:
-------------------- Input -------------------
  Client_id     = 86
  item_num      = 0
  Coins in:
  [ 0] 25 RUB
  [ 1] 50 RUB
  [ 2] 25 EUR
  [ 3]  5 USD
  [ 4] 50 USD
-------------------- Output ------------------
  item_out      = 0000000001
  change_out    = 252
  no_change     = 0
  client_points = 6
  item_empty    = 0000000000
----------------------------------------------

Expected:
-------------------- Input -------------------
  Client_id     = 86
  item_num      = 0
  Coins in:
  [ 0] 25 RUB
  [ 1] 50 RUB
  [ 2] 25 EUR
  [ 3]  5 USD
  [ 4] 50 USD
-------------------- Output ------------------
  item_out      = 0000000001
  change_out    = 265
  no_change     = 0
  client_points = 5
  item_empty    = 0000000000
----------------------------------------------


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../agents/user_agent/user_transaction.sv |Line: 147
Time: 2175 ns | uvm_root              | user_transaction: 
Message: Change issued error:
Get transaction:
-------------------- Input -------------------
  Client_id     = 6
  item_num      = 5
  Coins in:
  [ 0] 25 EUR
  [ 1] 25 USD
  [ 2] 50 RUB
  [ 3]  1 RUB
  [ 4]  5 EUR
  [ 5] 10 EUR
  [ 6]  5 RUB
-------------------- Output ------------------
  item_out      = 0000100000
  change_out    = 166
  no_change     = 0
  client_points = 9
  item_empty    = 0000000000
----------------------------------------------

Expected:
-------------------- Input -------------------
  Client_id     = 6
  item_num      = 5
  Coins in:
  [ 0] 25 EUR
  [ 1] 25 USD
  [ 2] 50 RUB
  [ 3]  1 RUB
  [ 4]  5 EUR
  [ 5] 10 EUR
  [ 6]  5 RUB
-------------------- Output ------------------
  item_out      = 0000100000
  change_out    = 226
  no_change     = 0
  client_points = 6
  item_empty    = 0000000000
----------------------------------------------


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../agents/user_agent/user_transaction.sv |Line: 163
Time: 2175 ns | uvm_root              | user_transaction: 
Message: Points accrual error:
Get transaction:
-------------------- Input -------------------
  Client_id     = 6
  item_num      = 5
  Coins in:
  [ 0] 25 EUR
  [ 1] 25 USD
  [ 2] 50 RUB
  [ 3]  1 RUB
  [ 4]  5 EUR
  [ 5] 10 EUR
  [ 6]  5 RUB
-------------------- Output ------------------
  item_out      = 0000100000
  change_out    = 166
  no_change     = 0
  client_points = 9
  item_empty    = 0000000000
----------------------------------------------

Expected:
-------------------- Input -------------------
  Client_id     = 6
  item_num      = 5
  Coins in:
  [ 0] 25 EUR
  [ 1] 25 USD
  [ 2] 50 RUB
  [ 3]  1 RUB
  [ 4]  5 EUR
  [ 5] 10 EUR
  [ 6]  5 RUB
-------------------- Output ------------------
  item_out      = 0000100000
  change_out    = 226
  no_change     = 0
  client_points = 6
  item_empty    = 0000000000
----------------------------------------------
```

## 4. Artifacts

- Full simulation log: `sim/runs/client_session_after_change_discount_test_seed_106891/sim_log_client_session_after_change_discount_test_1.log`
- Waveform file (WLF): `sim/runs/client_session_after_change_discount_test_seed_106891/vsim_client_session_after_change_discount_test_1.wlf`
