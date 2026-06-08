import os
import sys
import subprocess
import random
import platform
import datetime
import argparse
import yaml

def parse_arguments():
    """Настройка аргументов командной строки"""
    parser = argparse.ArgumentParser(
        description="Универсальный скрипт запуска UVM симуляций (QuestaSim)",
        formatter_class=argparse.RawTextHelpFormatter
    )
    
    parser.add_argument(
        "-t", "--test", type=str, default=None,
        help="Имя конкретного теста для запуска. Перекрывает групповые настройки."
    )
    parser.add_argument(
        "-g", "--group", type=str, default="all",
        help="Имя группы тестов для запуска (например: register_tests, emergency_tests).\n"
             "Если указано 'all' (по умолчанию), запустятся все активные тесты из всех групп."
    )
    parser.add_argument(
        "-c", "--count", type=int, default=1,
        help="Количество запусков (только если указан конкретный тест через -t)."
    )
    parser.add_argument(
        "-v", "--verbosity", type=str, default="UVM_LOW",
        choices=["UVM_NONE", "UVM_LOW", "UVM_MEDIUM", "UVM_HIGH", "UVM_FULL", "UVM_DEBUG"],
        help="Уровень детализации логов UVM. По умолчанию: UVM_LOW"
    )
    parser.add_argument(
        "-s", "--seed", type=int, default=None,
        help="Конкретный seed для симуляции."
    )
    parser.add_argument(
        "--quiet", action="store_true",
        help="Глушить вывод симулятора в консоль."
    )
    parser.add_argument(
        "--skip_compile", action="store_true",
        help="Пропустить шаг очистки и компиляции."
    )

    return parser.parse_args()


def run_cmd(cmd, suppress_output=False):
    """Запуск системных команд"""
    if suppress_output:
        return subprocess.run(cmd, shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    else:
        return subprocess.run(cmd, shell=True)


def main():
    args = parse_arguments()

    # Определение команды Make в зависимости от ОС
    make_cmd = "make"
    if platform.system() == "Windows":
        import shutil
        if shutil.which("mingw32-make"):
            make_cmd = "mingw32-make"

    # 1. Шаг компиляции
    if not args.skip_compile:
        print(f"--- Cleaning and Compiling using {make_cmd} ---")
        run_cmd(f"{make_cmd} clean_all", suppress_output=False)
        comp_result = run_cmd(f"{make_cmd} compile", suppress_output=False)
        if comp_result.returncode != 0:
            print("\n[ERROR] Compilation Failed!")
            sys.exit(1)

    # 2. Загрузка конфигурации тестов из YAML
    yaml_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), "tests_suite.yaml")
    if not os.path.exists(yaml_path):
        print(f"[ERROR] Configuration file '{yaml_path}' not found! Run sync_testlist.py first.")
        sys.exit(1)

    with open(yaml_path, "r", encoding="utf-8") as f:
        config_data = yaml.safe_load(f)

    yaml_defaults = config_data.get("defaults", {"count": 1, "verbosity": "UVM_LOW"})
    suites = config_data.get("suites", {})

    # 3. Формирование финального списка тестов на запуск с учетом выбранной группы
    tests_to_run = [] # Используем список кортежей (test_name, config, group_name) для логирования

    if args.test:
        # Одиночный запуск теста из консоли имеет наивысший приоритет
        tests_to_run.append((args.test, {"count": args.count, "verbosity": args.verbosity}, "CLI_OVERRIDE"))
    else:
        # Фильтруем группы тестов
        target_suites = {}
        if args.group == "all":
            target_suites = suites
        else:
            if args.group in suites:
                target_suites = {args.group: suites[args.group]}
            else:
                print(f"[ERROR] Group '{args.group}' not found in {yaml_path}!")
                print(f"Available groups: {list(suites.keys())}")
                sys.exit(1)

        # Извлекаем тесты из выбранных групп
        for group_name, group_tests in target_suites.items():
            if not group_tests:
                continue
            for test_name, test_cfg in group_tests.items():
                if test_cfg is None:
                    test_cfg = {}

                final_count = test_cfg.get("count", yaml_defaults.get("count", 1))
                
                if args.verbosity != "UVM_LOW":
                    final_verbosity = args.verbosity
                else:
                    final_verbosity = test_cfg.get("verbosity", yaml_defaults.get("verbosity", "UVM_LOW"))

                if final_count > 0:
                    tests_to_run.append((test_name, {"count": final_count, "verbosity": final_verbosity}, group_name))

    if not tests_to_run:
        print("No active tests found for execution. Exiting.")
        sys.exit(0)

    # 4. Цикл симуляций
    print("\n--- Starting Simulations ---")
    show_console = not args.quiet
    ucdb_files = []

    for test_name, cfg, group_name in tests_to_run:
        run_count = cfg["count"]
        verbosity = cfg["verbosity"]

        for i in range(1, run_count + 1):
            seed = args.seed if (args.seed is not None) else random.randint(1, 999999)
            current_time = datetime.datetime.now().strftime("%d.%m.%Y_%H:%M:%S")

            if show_console:
                print(f"\n" + "="*75)
                print(f" STARTING: {test_name} (Iter: {i}/{run_count}, Seed: {seed})")
                print(f" Group   : {group_name} | Verbosity: {verbosity}")
                print(f"=========" + "="*66)
            else:
                print(f"Running {test_name} [{group_name}] (Iter: {i}/{run_count}, Seed: {seed})... ", end="", flush=True)

            # Команда симуляции
            make_sim_cmd = (
                f"{make_cmd} sim "
                f"TEST_NAME={test_name} "
                f"SEED={seed} "
                f"VERBOSITY={verbosity} "
                f"ITER={i} "
                f"SIM_START_TIME={current_time}"
            )

            result = run_cmd(make_sim_cmd, suppress_output=args.quiet)

            if not show_console:
                if result.returncode == 0:
                    print("DONE")
                else:
                    print("FAILED")

            ucdb_files.append(f"ucdb_{test_name}_{i}.ucdb")

    # Сбор покрытия (только для полного запуска регрессии)
    if ucdb_files and args.group == "all" and not args.test:
        print("\n--- Merging Coverage ---")
        run_cmd(f"{make_cmd} merge_coverage", suppress_output=False)
        print("Coverage merged into total.ucdb")


if __name__ == "__main__":
    main()