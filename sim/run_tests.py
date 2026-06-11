import datetime
import random
import os


from infra.config_manager import ConfigManager
from infra.artifact_manager import ArtifactManager
from infra.sim_runner import SimulationRunner
from infra.report_server import ReportServer


class RegressionOrchestrator:
    def __init__(self):
        self.cm = ConfigManager()
        self.am = ArtifactManager()
        self.runner = SimulationRunner()
        self.reporter = ReportServer()

    def execute(self):
        # 1. Фаза конфигурации
        args = self.cm.parse_arguments()
        self.cm.load_suite_config()
        tests_to_run = self.cm.generate_test_list()

        # 2. Фаза очистки артефактов
        if args.test:
            # Чистим артефакты индивидуально для каждого указанного теста
            cli_tests = [t.strip() for t in args.test.split(",") if t.strip()]
            for t_name in cli_tests:
                self.am.clean(test_name=t_name, skip_bugs=args.no_report)
        elif args.group == "all":
            self.am.clean(test_name=None, skip_bugs=args.no_report)

        # 3. Фаза компиляции RTL и TB
        if not args.skip_compile:
            self.runner.compile_design()

        print("\n--- Starting Simulations ---")
        
        # 4. Фаза симуляций
        for test in tests_to_run:
            for i in range(1, test["count"] + 1):
                seed = args.seed if (args.seed is not None) else random.randint(1, 999999)
                current_time = datetime.datetime.now().strftime("%d.%m.%Y_%H:%M:%S")
                
                # Создаем изолированную подпапку под этот сид
                run_dir_name, run_dir_path = self.am.create_run_directory(test["name"], seed)
                
                if not args.quiet:
                    print(f"\n" + "="*75 + f"\n STARTING: {test['name']} (Iter: {i}/{test['count']}, Seed: {seed})\n Group   : {test['group']} | Verbosity: {test['verbosity']}\n" + "="*75)
                else:
                    print(f"Running {test['name']} [{test['group']}] (Iter: {i}/{test['count']}, Seed: {seed})... ", end="", flush=True)

                # Запуск Симулятора
                sim_result = self.runner.run_simulation(
                    test_name=test["name"], seed=seed, verbosity=test["verbosity"],
                    iter_num=i, run_dir_name=run_dir_name, current_time=current_time, quiet=args.quiet
                )

                # Проверка флага падения теста
                abs_error_log = os.path.join(run_dir_path, f"errors_{test['name']}_{i}.log")
                test_failed = (sim_result.returncode != 0) or os.path.exists(abs_error_log)

                if args.quiet:
                    print("DONE" if not test_failed else "FAILED")

                # Обработка отчетов о багах
                if test_failed:
                    if not args.no_report:
                        self.reporter.generate_bug_report(test["name"], i, seed, test["verbosity"], test["group"], run_dir_path)
                    else:
                        if os.path.exists(abs_error_log): 
                            os.remove(abs_error_log)

                self.reporter.register_result(test["name"], test["group"], seed, current_time, test_failed)

        # 5. Фаза сборки покрытия (только при полной регрессии)
        if args.group == "all" and not args.test:
            self.runner.merge_coverage()

        # 6. Финальный отчет
        if not args.no_report:
            self.reporter.generate_summary_report()

if __name__ == "__main__":
    orchestrator = RegressionOrchestrator()
    orchestrator.execute()