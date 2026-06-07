import os
import sys
import subprocess
import random
import platform

# Список тестов и количество запусков
TESTS = {
    "dollars_test": 1,
    "check_write_test": 0,
    "client_session_after_change_discount_test": 0
}

VERBOSITY = "UVM_LOW"

# Определяем команду запуска утилиты Make для текущей ОС
MAKE_CMD = "make"
if platform.system() == "Windows":
    # Если на Windows используется mingw32-make, скрипт попробует использовать её
    # Если у вас стандартный make, можете оставить просто "make"
    import shutil
    if shutil.which("mingw32-make"):
        MAKE_CMD = "mingw32-make"

def run_cmd(cmd, log_file=None):
    """Безопасный запуск команд через subprocess"""
    if log_file:
        with open(log_file, "w") as f:
            return subprocess.run(cmd, shell=True, stdout=f, stderr=f)
    else:
        return subprocess.run(cmd, shell=True)

def main():
    # 1. Очистка и компиляция
    print(f"--- Cleaning and Compiling using {MAKE_CMD} ---")
    run_cmd(f"{MAKE_CMD} clean_all")
    comp_result = run_cmd(f"{MAKE_CMD} compile")
    
    if comp_result.returncode != 0:
        print("Compilation Failed! Check logs.")
        sys.exit(1)

    # 2. Запуск регрессии
    print("\n--- Starting Simulations ---")
    ucdb_files = []

    for test_name, run_count in TESTS.items():
        for i in range(1, run_count + 1):
            seed = random.randint(1, 999999)
            log_name = f"sim_log_{test_name}_{i}.log"
            
            print(f"Running {test_name} (Iter: {i}, Seed: {seed})... ", end="", flush=True)
            
            # Передаем параметры в универсальный Makefile
            make_sim_cmd = (
                f"{MAKE_CMD} sim "
                f"TEST_NAME={test_name} "
                f"SEED={seed} "
                f"VERBOSITY={VERBOSITY} "
                f"ITER={i}"
            )
            
            result = run_cmd(make_sim_cmd, log_file=log_name)
            
            if result.returncode == 0:
                print("DONE")
                ucdb_files.append(f"ucdb_{test_name}_{i}.ucdb")
            else:
                print("FAILED (Check log file)")

    # 3. Сбор покрытия
    if ucdb_files:
        print("\n--- Merging Coverage ---")
        run_cmd(f"{MAKE_CMD} merge_coverage")
        print("Coverage merged into total.ucdb")

if __name__ == "__main__":
    main()