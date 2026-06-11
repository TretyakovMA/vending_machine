import os
import glob
import shutil

class ArtifactManager:
    def __init__(self):
        # Находимся в sim/infra/
        infra_dir = os.path.dirname(os.path.abspath(__file__))
        # Поднимаемся на уровень выше — в корень sim/
        self.sim_dir = os.path.abspath(os.path.join(infra_dir, ".."))
        
        self.bugs_dir = os.path.join(self.sim_dir, "bugs")
        self.runs_dir = os.path.join(self.sim_dir, "runs")

    def clean(self, test_name=None, skip_bugs=False):
        """Умная очистка: точечная для теста или тотальная для всей регрессии"""
        if test_name:
            print(f"[INFO] Cleaning old artifacts for test: '{test_name}'...")
            # Удаляем баг-репорты конкретного теста, только если НЕ активен skip_bugs
            if not skip_bugs and os.path.exists(self.bugs_dir):
                for bug_file in glob.glob(os.path.join(self.bugs_dir, f"bug_{test_name}_seed_*.md")):
                    self._safe_remove(bug_file)
            if os.path.exists(self.runs_dir):
                for run_folder in glob.glob(os.path.join(self.runs_dir, f"{test_name}_seed_*")):
                    self._safe_remove(run_folder, is_dir=True)
        else:
            print("[INFO] Performing total cleanup of previous regression results...")
            # Формируем список путей для полной очистки
            paths_to_clean = [self.runs_dir, os.path.join(self.sim_dir, "summary.md")]
            if not skip_bugs:
                paths_to_clean.append(self.bugs_dir)
                
            for path in paths_to_clean:
                if os.path.exists(path):
                    self._safe_remove(path, is_dir=os.path.isdir(path))

    def create_run_directory(self, test_name, seed):
        """Создает изолированную папку для конкретного сида симуляции"""
        run_dir_name = f"runs/{test_name}_seed_{seed}"
        run_dir_path = os.path.join(self.sim_dir, run_dir_name)
        os.makedirs(run_dir_path, exist_ok=True)
        return run_dir_name, run_dir_path

    def _safe_remove(self, path, is_dir=False):
        try:
            shutil.rmtree(path) if is_dir else os.remove(path)
        except OSError:
            pass