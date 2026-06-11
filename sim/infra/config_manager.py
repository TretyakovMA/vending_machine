import os
import argparse
from typing import Optional, List, Dict, Any
import yaml
from .testplan_parser import TestplanParser

class ConfigManager:
    def __init__(self, yaml_name: str = "tests_suite.yaml"):
        # Находимся в sim/infra/
        infra_dir = os.path.dirname(os.path.abspath(__file__))
        # Поднимаемся в корень sim/
        sim_dir = os.path.abspath(os.path.join(infra_dir, ".."))
        
        self.yaml_path = os.path.join(sim_dir, yaml_name)
        # Явно указываем анализатору, что тип может быть Namespace или None
        self.args: Optional[argparse.Namespace] = None
        self.defaults: Dict[str, Any] = {"count": 1, "verbosity": "UVM_LOW"}
        self.suites: Dict[str, Any] = {}

    def parse_arguments(self) -> argparse.Namespace:
        parser = argparse.ArgumentParser(
            description="Универсальный ООП-скрипт запуска UVM симуляций",
            formatter_class=argparse.RawTextHelpFormatter
        )
        parser.add_argument("-t", "--test", type=str, default=None, help="Имя конкретного теста")
        parser.add_argument("-g", "--group", type=str, default="all", help="Имя группы тестов")
        parser.add_argument("-c", "--count", type=int, default=None, help="Количество запусков")
        parser.add_argument("-v", "--verbosity", type=str, default="UVM_LOW", help="UVM Verbosity")
        parser.add_argument("-s", "--seed", type=int, default=None, help="Конкретный seed")
        parser.add_argument("--quiet", action="store_true", help="Глушить вывод симулятора")
        parser.add_argument("--skip_compile", action="store_true", help="Пропустить компиляцию")
        parser.add_argument("--no_report", action="store_true", help="Отключить генерацию отчетов")
        
        self.args = parser.parse_args()
        return self.args



    def load_suite_config(self) -> None:
        if self.args is None:
            raise RuntimeError("Вызовите parse_arguments() перед загрузкой конфигурации!")

        # Создаем экземпляр парсера
        syncer = TestplanParser(yaml_path=self.yaml_path)
        
        # Умная синхронизация: если Excel обновился ИЛИ пользователь явно попросил обновить через CLI
        # (Для этого можно добавить аргумент --force_sync в parse_arguments при желании)
        force_sync = getattr(self.args, "force_sync", False)
        
        if force_sync or syncer.is_sync_needed():
            syncer.sync()
        
        # Дальнейший стандартный код чтения YAML
        if not os.path.exists(self.yaml_path):
            raise FileNotFoundError(f"Конфигурационный файл '{self.yaml_path}' не найден!")
            
        with open(self.yaml_path, "r", encoding="utf-8") as f:
            config_data = yaml.safe_load(f)
            
        self.defaults = config_data.get("defaults", self.defaults)
        self.suites = config_data.get("suites", {})



    def generate_test_list(self) -> List[Dict[str, Any]]:
        """Формирует финальный массив словарей с параметрами для каждого запуска"""
        # ЗАЩИТА ТИПА (Type Guard): Объясняем Pylance, что ниже self.args ТОЧНО не равен None
        if self.args is None:
            raise RuntimeError("Необходимо вызвать parse_arguments() перед генерацией списка тестов!")

        tests_to_run: List[Dict[str, Any]] = []
        
        # 1. Сценарий: Явный список тестов через CLI (флаг -t)
        if self.args.test:

            # Расщепляем строку по запятой и зачищаем пробелы
            cli_tests = [t.strip() for t in self.args.test.split(",") if t.strip()]
            
            # Если пользователь передал -c, берем его, иначе базовый default (1)
            final_count = self.args.count if self.args.count is not None else self.defaults.get("count", 1)

            for test_name in cli_tests:
                tests_to_run.append({
                    "name": test_name,
                    "count": final_count,
                    "verbosity": self.args.verbosity,
                    "group": "CLI_OVERRIDE"
                })
            return tests_to_run




        # 2. Сценарий: Запуск группы или всей регрессии
        target_suites = self.suites if self.args.group == "all" else {self.args.group: self.suites.get(self.args.group)}
        if not target_suites or None in target_suites.values():
            raise ValueError(f"Группа '{self.args.group}' не найдена в YAML!")

        for group_name, group_tests in target_suites.items():
            if not group_tests:
                continue
            for test_name, test_cfg in group_tests.items():
                test_cfg = test_cfg or {}
                
                # ЛОГИКА ПЕРЕКРЫТИЯ СЧЕТЧИКА:
                # Если в CLI передан -c, он жестко доминирует над тестпланом.
                # Если -c НЕ передан, берем значение из тестплана, если и его нет — default (1).
                if self.args.count is not None:
                    count = self.args.count
                else:
                    count = test_cfg.get("count", self.defaults.get("count", 1))
                
                verbosity = self.args.verbosity if self.args.verbosity != "UVM_LOW" else test_cfg.get("verbosity", self.defaults.get("verbosity", "UVM_LOW"))
                
                if count > 0:
                    tests_to_run.append({
                        "name": test_name,
                        "count": count,
                        "verbosity": verbosity,
                        "group": group_name
                    })

        return tests_to_run