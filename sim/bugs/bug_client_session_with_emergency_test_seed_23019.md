# [BUG] client_session_with_emergency_test failed with seed 23019

## 1. Environment

- **Test Name:** `client_session_with_emergency_test`
- **Group:** `integration_tests`
- **Seed:** `23019`
- **Git Commit:** `42dfb73`
- **Date/Time:** 11.06.2026 20:20:52

## 2. Steps to Reproduce

```bash
python run_tests.py -t client_session_with_emergency_test -s 23019 -v UVM_LOW --skip_compile
```

> Перезапуск с логами интерфейсов:
>
> ```bash
> python run_tests.py -t client_session_with_emergency_test -s 23019 -v UVM_HIGH --skip_compile
> ```

## 3. Extracted Failures

```text
UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 286
Time: 155 ns | vm_scoreboard         | vm_scoreboard: 
Message: Error occurred but item_out = 0000000010


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 289
Time: 155 ns | vm_scoreboard         | vm_scoreboard: 
Message: Error occurred but change_out = 168


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 286
Time: 265 ns | vm_scoreboard         | vm_scoreboard: 
Message: Error occurred but item_out = 0000000001


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 289
Time: 265 ns | vm_scoreboard         | vm_scoreboard: 
Message: Error occurred but change_out = 167


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 286
Time: 395 ns | vm_scoreboard         | vm_scoreboard: 
Message: Error occurred but item_out = 0001000000


UVM_ERROR
C:/SV/vending_machine/sim/../tb/include/../scoreboard/vm_scoreboard.sv |Line: 289
Time: 395 ns | vm_scoreboard         | vm_scoreboard: 
Message: Error occurred but change_out = 213
```

## 4. Artifacts

- Full simulation log: `sim/runs/client_session_with_emergency_test_seed_23019/sim_log_client_session_with_emergency_test_1.log`
- Waveform file (WLF): `sim/runs/client_session_with_emergency_test_seed_23019/vsim_client_session_with_emergency_test_1.wlf`
