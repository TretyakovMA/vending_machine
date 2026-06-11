import os
import datetime
import subprocess
import re

class ReportServer:
    def __init__(self):
        self.results = []
        self.start_regress_time = datetime.datetime.now().strftime("%d.%m.%Y %H:%M:%S")
        # Находимся в sim/infra/, берем родительскую папку как sim_dir
        self.infra_dir = os.path.dirname(os.path.abspath(__file__))
        self.sim_dir = os.path.abspath(os.path.join(self.infra_dir, ".."))
        
    def get_git_hash(self):
        try:
            return subprocess.check_output(["git", "rev-parse", "--short", "HEAD"]).decode("utf-8").strip()
        except Exception:
            return "N/A"

    def register_result(self, test_name, group, seed, current_time, is_failed):
        status = "FAILED" if is_failed else "PASSED"
        self.results.append({
            "name": test_name,
            "group": group,
            "seed": seed,
            "time": current_time,
            "status": status,
            "bug_file": f"bugs/bug_{test_name}_seed_{seed}.md" if is_failed else "—"
        })

        if is_failed:
            self.register_global_bug(test_name, seed)

    def generate_bug_report(self, test_name, iter_num, seed, verbosity, group_name, run_dir_path):
        bugs_dir = os.path.join(self.sim_dir, "bugs")
        os.makedirs(bugs_dir, exist_ok=True)
        
        sim_log_name = f"sim_log_{test_name}_{iter_num}.log"
        error_log_name = f"errors_{test_name}_{iter_num}.log"
        abs_error_log_path = os.path.join(run_dir_path, error_log_name)
        
        rel_run_dir = os.path.relpath(run_dir_path, self.sim_dir).replace("\\", "/")
        
        # Чтение лога ошибок
        if os.path.exists(abs_error_log_path):
            with open(abs_error_log_path, "r", encoding="utf-8") as f:
                error_content = f.read()
            try: os.remove(abs_error_log_path)
            except OSError: pass
        else:
            error_content = "*Критический сбой инфраструктуры симулятора.*"

        bug_report_path = os.path.join(bugs_dir, f"bug_{test_name}_seed_{seed}.md")
        reproduce_cmd = f"python run_tests.py -t {test_name} -s {seed} -v {verbosity} --skip_compile"
        high_verb_cmd = f"python run_tests.py -t {test_name} -s {seed} -v UVM_HIGH --skip_compile"

        with open(bug_report_path, "w", encoding="utf-8") as f:
            f.write(f"# [BUG] {test_name} failed with seed {seed}\n\n")
            f.write(f"## 1. Environment\n\n- **Test Name:** `{test_name}`\n- **Group:** `{group_name}`\n- **Seed:** `{seed}`\n- **Git Commit:** `{self.get_git_hash()}`\n- **Date/Time:** {datetime.datetime.now().strftime('%d.%m.%Y %H:%M:%S')}\n\n")
            f.write(f"## 2. Steps to Reproduce\n\n```bash\n{reproduce_cmd}\n```\n\n")
            f.write(f"> Перезапуск с логами интерфейсов:\n>\n> ```bash\n> {high_verb_cmd}\n> ```\n\n")
            f.write(f"## 3. Extracted Failures\n\n```text\n{error_content.strip()}\n```\n\n")
            f.write(f"## 4. Artifacts\n\n- Full simulation log: `sim/{rel_run_dir}/{sim_log_name}`\n- Waveform file (WLF): `sim/{rel_run_dir}/vsim_{test_name}_{iter_num}.wlf`\n")
            
        print(f"   [BUG REPORT GENERATED] -> {bug_report_path}")

    def generate_summary_report(self):
        # Возвращаем расширение .md
        summary_path = os.path.join(self.sim_dir, "summary.md")
        total_tests = len(self.results)
        passed_tests = sum(1 for r in self.results if r["status"] == "PASSED")
        failed_tests = total_tests - passed_tests
        pass_rate = (passed_tests / total_tests * 100) if total_tests > 0 else 0.0
        
        regress_status = "[PASSED]" if failed_tests == 0 else "[FAILED]"
        
        with open(summary_path, "w", encoding="utf-8") as f:
            # Заголовок отчета
            f.write(f"# {regress_status} Regression Summary Report\n\n")
            
            # Раздел 1: Метрики
            f.write("## 1. Metrics\n\n")
            f.write(f"- **Start Time:** {self.start_regress_time}\n")
            f.write(f"- **End Time:** {datetime.datetime.now().strftime('%d.%m.%Y %H:%M:%S')}\n")
            f.write(f"- **Git Commit:** `{self.get_git_hash()}`\n")
            f.write(f"- **Total Tests Run:** {total_tests}\n")
            f.write(f"- **Passed:** {passed_tests}\n")
            f.write(f"- **Failed:** {failed_tests}\n")
            f.write(f"- **Pass Rate:** {pass_rate:.1f}%\n\n")
            
            # Раздел 2: Таблица с результатами
            f.write("## 2. Test List Summary\n\n")
            f.write("| # | Test Name | Group | Seed | Start Time | Status | Bug Report / Details |\n")
            f.write("| --- | --- | --- | --- | --- | --- | --- |\n")
            
            for idx, r in enumerate(self.results, 1):
                # Никаких цветов, статус выделяется стандартным жирным шрифтом Markdown
                status_str = "*PASSED*" if r["status"] == "PASSED" else "***FAILED***"
                
                # Ссылка на баг-репорт в формате Markdown
                bug_link = f"[View Bug Report]({r['bug_file']})" if r["status"] == "FAILED" else "—"
                
                f.write(f"| {idx} | `{r['name']}` | {r['group']} | {r['seed']} | {r['time']} | {status_str} | {bug_link} |\n")
            
        print(f"\n[SUCCESS] Regression summary report generated at: {summary_path}")


    def register_global_bug(self, test_name, seed):
        """Интегрированный баг-трекер внутри ReportServer"""
        bugs_file_path = os.path.join(self.sim_dir, "bugs_status.md")
        
        # 1. Инициализация файла, если он еще не существует
        if not os.path.exists(bugs_file_path):
            with open(bugs_file_path, "w", encoding="utf-8") as f:
                f.write("# RTL Bugs Tracking List\n\n")
                f.write("| ID | Test Name | Seed | Status | Description / Root Cause | Fix Commit |\n")
                f.write("| --- | --- | --- | --- | --- | --- |\n")

        # 2. Читаем текущий статус всех заведенных багов
        with open(bugs_file_path, "r", encoding="utf-8") as f:
            lines = f.readlines()

        # Проверяем, есть ли уже этот тест в файле
        test_exists = False
        for line in lines:
            # Строка таблицы выглядит так: | BUG-01 | check_read_test | ...
            # Регулярка проверяет точное совпадение имени теста внутри ячейки
            if re.search(r'\|\s*' + re.escape(test_name) + r'\s*\|', line):
                test_exists = True
                break

        if test_exists:
            # Мы не дублируем запись, если этот тест уже зафиксирован в bugs_status.md
            return

        # 3. Вычисляем следующий ID (BUG-01, BUG-02 и т.д.)
        full_content = "".join(lines)
        existing_ids = re.findall(r"BUG-(\d+)", full_content)
        next_id_num = max([int(x) for x in existing_ids]) + 1 if existing_ids else 1
        bug_id = f"BUG-{next_id_num:02d}"

        # 4. Формируем новую строку для таблицы
        new_row = f"| {bug_id} | {test_name} | {seed} | **OPEN** | Автоматически добавлен при падении. Требуется Root Cause анализ. | — |\n"
        
        # 5. Дописываем баг в конец файла
        with open(bugs_file_path, "a", encoding="utf-8") as f:
            f.write(new_row)
        
        print(f"   [BUG TRACKER] Зарегистрирован НОВЫЙ уникальный баг: {bug_id} для теста {test_name}")