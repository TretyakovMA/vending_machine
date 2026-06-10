import os
import sys
import subprocess
import random
import platform
import datetime
import argparse
import yaml
import glob
import shutil

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
    parser.add_argument(
        '--no_report', 
        action='store_true', 
        help='Отключает генерацию индивидуальных bug_report и финального summary.md (режим отладки TB)'
    )

    return parser.parse_args()


def run_cmd(cmd, suppress_output=False):
    """Запуск системных команд"""
    if suppress_output:
        return subprocess.run(cmd, shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    else:
        return subprocess.run(cmd, shell=True)



def get_git_hash():
    """Получает короткий хэш текущего коммита Git"""
    try:
        return subprocess.check_output(["git", "rev-parse", "--short", "HEAD"]).decode("utf-8").strip()
    except Exception:
        return "N/A (Not a git repository or git not installed)"


def generate_bug_report(test_name, iter_num, seed, verbosity, group_name, run_dir_path):
    """Преобразует созданный SystemVerilog файл ошибок в красивый Markdown баг-репорт"""
    sim_log_name = f"sim_log_{test_name}_{iter_num}.log"
    error_log_name = f"errors_{test_name}_{iter_num}.log"
    bugs_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), "bugs")
    
    os.makedirs(bugs_dir, exist_ok=True)
    bug_report_path = os.path.join(bugs_dir, f"bug_{test_name}_seed_{seed}.md")
    
    error_log_path = os.path.join(run_dir_path, error_log_name)
    rel_run_dir = os.path.relpath(run_dir_path, os.path.dirname(os.path.abspath(__file__))).replace("\\", "/")
    sim_log_path = f"{rel_run_dir}/{sim_log_name}"
    
    # Читаем готовые ошибки, которые SV заботливо отфильтровал для нас
    error_content = ""
    if os.path.exists(error_log_path):
        with open(error_log_path, "r", encoding="utf-8") as f:
            error_content = f.read()
        # Удаляем временный файл ошибок SV, так как мы переносим его в bug report
        try:
            os.remove(error_log_path)
        except OSError:
            pass
    else:
        error_content = "*Критический сбой инфраструктуры (код возврата не 0), UVM не успел сгенерировать отчет.*"

    reproduce_cmd = f"python run_regress.py -t {test_name} -s {seed} -v {verbosity} --skip_compile"
    high_verb_cmd = f"python run_regress.py -t {test_name} -s {seed} -v UVM_HIGH --skip_compile"

    # Создаем финальный Bug Report
    with open(bug_report_path, "w", encoding="utf-8") as f:
        f.write(f"# [BUG] {test_name} failed with seed {seed}\n\n")
        
        f.write("## 1. Environment\n\n")
        f.write(f"- **Test Name:** `{test_name}`\n")
        f.write(f"- **Group:** `{group_name}`\n")
        f.write(f"- **Seed:** `{seed}`\n")
        f.write(f"- **Git Commit:** `{get_git_hash()}`\n")
        f.write(f"- **Date/Time:** {datetime.datetime.now().strftime('%d.%m.%Y %H:%M:%S')}\n\n")
        
        f.write("## 2. Steps to Reproduce\n\n")
        f.write(f"```bash\n{reproduce_cmd}\n```\n\n")

        f.write("> Если вам нужны подробные логи работы интерфейсов (какой сигнал/транзакция и в какой момент времени были отправлены или приняты), перезапустите тест с уровнем детализации **`UVM_HIGH`**:\n>\n")
        f.write(f"> ```bash\n> {high_verb_cmd}\n> ```\n>\n")
        f.write("> Более глубокие уровни (`UVM_FULL` и `UVM_DEBUG`) использовать **не нужно** — они перегружены внутренними отладочными сообщениями самого тестбенча и предназначены только для верификатора.\n\n")
        
        # Секция для ваших ручных комментариев (до огромного текста ошибок)
        f.write("## 3. Verification Comments & Analysis\n\n")
        
        # Секция сбоя ушла вниз
        f.write("## 4. Extracted Failures\n\n")
        f.write(f"```text\n{error_content.strip()}\n```\n\n")
        
        f.write("## 5. Artifacts\n\n")
        f.write(f"- Full simulation log: `sim/{run_dir_path}/{sim_log_name}`\n")
        f.write(f"- Waveform file (WLF): `sim/{run_dir_path}/vsim_{test_name}_{iter_num}.wlf`\n")

    print(f"   [BUG REPORT GENERATED] -> {bug_report_path}")



def generate_summary_report(results, start_time):
    """Генерирует сводный отчет по результатам всей регрессии в файл summary.md"""
    summary_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), "summary.md")
    
    total_tests = len(results)
    passed_tests = sum(1 for r in results if r["status"] == "PASSED")
    failed_tests = total_tests - passed_tests
    pass_rate = (passed_tests / total_tests * 100) if total_tests > 0 else 0.0
    
    # Определяем глобальный статус для главного заголовка
    regress_status = "[PASSED]" if failed_tests == 0 else "[FAILED]"
    
    with open(summary_path, "w", encoding="utf-8") as f:
        f.write(f"# {regress_status} Regression Summary Report\n\n")
        
        f.write("## 1. Metrics\n\n")
        f.write(f"- **Start Time:** {start_time}\n")
        f.write(f"- **End Time:** {datetime.datetime.now().strftime('%d.%m.%Y %H:%M:%S')}\n")
        f.write(f"- **Git Commit:** `{get_git_hash()}`\n")
        f.write(f"- **Total Tests Run:** {total_tests}\n")
        f.write(f"- **Passed:** {passed_tests}\n")
        f.write(f"- **Failed:** {failed_tests}\n")
        f.write(f"- **Pass Rate:** {pass_rate:.1f}%\n\n")
        
        f.write("## 2. Test List Summary\n\n")
        f.write("| # | Test Name | Group | Seed | Start Time | Status | Bug Report / Details |\n")
        f.write("|---|---|---|---|---|---|---|\n")
        
        for idx, r in enumerate(results, 1):
            if r["status"] == "FAILED":
                # Красиво подсвечиваем FAILED красным цветом с помощью HTML-тега
                status_str = "<span style='color:red'>**FAILED**</span>"
                bug_link = f"[View Bug Report]({r['bug_file']})"
            else:
                status_str = "<span style='color:green'>**PASSED**</span>"
                bug_link = "—"
                
            f.write(f"| {idx} | `{r['name']}` | {r['group']} | {r['seed']} | {r['time']} | {status_str} | {bug_link} |\n")
            
    print(f"\n[SUCCESS] Global summary report generated at: summary.md (Pass Rate: {pass_rate:.1f}%)")




def clean_stale_artifacts(test_name=None):
    """
    Удаляет старые логи и баг-репорты перед запуском симуляции.
    Если test_name передан -> чистит артефакты только для этого теста.
    Если test_name равен None -> чистит вообще всё (тотальный сброс регрессии).
    """
    sim_dir = os.path.dirname(os.path.abspath(__file__))
    bugs_dir = os.path.join(sim_dir, "bugs")
    runs_dir = os.path.join(sim_dir, "runs")

    if test_name:
        print(f"[INFO] Cleaning old artifacts for test: '{test_name}'...")
        # 1. Удаляем старые баг-репорты этого теста (например, bugs/bug_axi_test_seed_123.md)
        if os.path.exists(bugs_dir):
            for bug_file in glob.glob(os.path.join(bugs_dir, f"bug_{test_name}_seed_*.md")):
                try: os.remove(bug_file)
                except OSError: pass

        # 2. Удаляем старые папки запусков этого теста (например, runs/axi_test_seed_123)
        if os.path.exists(runs_dir):
            for run_folder in glob.glob(os.path.join(runs_dir, f"{test_name}_seed_*")):
                try: shutil.rmtree(run_folder)
                except OSError: pass
    else:
        print("[INFO] Performing total cleanup of previous regression results...")
        # Тотальная очистка перед полной регрессией
        for path in [bugs_dir, runs_dir, os.path.join(sim_dir, "summary.md")]:
            if os.path.exists(path):
                if os.path.isdir(path): shutil.rmtree(path)
                else: os.remove(path)


# ============================================================================
# Главная функция
# ============================================================================
def main():
    args = parse_arguments()

    start_regress_time = datetime.datetime.now().strftime("%d.%m.%Y %H:%M:%S")
    regression_results = []

    # АВТО-ОЧИСТКА:
    # Если пользователь запустил один конкретный тест (-t имя_теста)
    if args.test:
        clean_stale_artifacts(test_name=args.test)
    # Если это запуск всей группы/регрессии — сносим всё старое целиком
    elif args.group == "all":
        clean_stale_artifacts(test_name=None)

    # Определение команды Make в зависимости от ОС
    #make_cmd = "make"
    #if platform.system() == "Windows":
    #    import shutil
    #    if shutil.which("mingw32-make"):
    #        make_cmd = "mingw32-make"

    # 1. Шаг компиляции
    if not args.skip_compile:
        print(f"--- Cleaning and Compiling using make ---")
        run_cmd(f"make clean_all", suppress_output=False)
        comp_result = run_cmd(f"make compile", suppress_output=False)
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


            # 1. Создаем уникальное имя папки для данного запуска
            run_dir_name = f"runs/{test_name}_seed_{seed}"
            run_dir_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), run_dir_name)
            
            # Физически создаем её на диске
            os.makedirs(run_dir_path, exist_ok=True)

            # Пути к файлам теперь учитывают эту папку
            sim_log_name = f"sim_log_{test_name}_{i}.log"
            error_log_name = f"errors_{test_name}_{i}.log"
            
            # Относительные пути для записи в файлы отчетов (.md)
            rel_sim_log_path = f"{run_dir_name}/{sim_log_name}"
            rel_error_log_path = f"{run_dir_name}/{error_log_name}"
            
            # Абсолютный путь к файлу ошибок, чтобы Python мог его проверить
            abs_error_log_path = os.path.join(run_dir_path, error_log_name)

            # Команда симуляции
            make_sim_cmd = (
                f"make sim "
                f"TEST_NAME={test_name} "
                f"SEED={seed} "
                f"VERBOSITY={verbosity} "
                f"ITER={i} "
                f"SIM_START_TIME={current_time} "
                f"RUN_DIR={run_dir_name}"
            )

            result = run_cmd(make_sim_cmd, suppress_output=args.quiet)

            # Имя файла ошибок, который должен был создать SystemVerilog
            error_log_name = f"errors_{test_name}_{i}.log"

            # Критерий падения: либо симулятор вернул ошибку, либо существует файл ошибок
            #test_failed = (result.returncode != 0) or os.path.exists(error_log_name)
            test_failed = (result.returncode != 0) or os.path.exists(abs_error_log_path)

            if not test_failed:
                if not show_console: print("DONE")
            else:
                if not show_console: print("FAILED")
                # Передаем управление генератору, он сам заберет файл и сделает из него красивый .md
                if not args.no_report:
                    generate_bug_report(
                        test_name=test_name,
                        iter_num=i,
                        seed=seed,
                        verbosity=verbosity,
                        group_name=group_name,
                        run_dir_path=run_dir_path
                    )
                else:
                    print("   [INFO] Режим --no_report активен. Баг-репорт пропущен.")
                    # Если файл ошибок был создан, но отчет мы не строим,
                    # просто удалим временный errors_*.log, чтобы не мусорить в папке runs/
                    if os.path.exists(abs_error_log_path):
                        try: os.remove(abs_error_log_path)
                        except OSError: pass
            
            regression_results.append({
                "name": test_name,
                "group": group_name,
                "seed": seed,
                "time": current_time,
                "status": "FAILED" if test_failed else "PASSED",
                "bug_file": f"bugs/bug_{test_name}_seed_{seed}.md" if test_failed else "—"
            })


            ucdb_files.append(f"ucdb_{test_name}_{i}.ucdb")

    # Сбор покрытия (только для полного запуска регрессии)
    if ucdb_files and args.group == "all" and not args.test:
        print("\n--- Merging Coverage ---")
        run_cmd(f"make merge_coverage", suppress_output=False)
        print("Coverage merged into total.ucdb")
    
    # 5. Генерация сводного отчета по результатам регрессии
    if not args.no_report:
        generate_summary_report(regression_results, start_regress_time)


if __name__ == "__main__":
    main()