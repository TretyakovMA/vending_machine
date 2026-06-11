import subprocess
import sys

class SimulationRunner:
    @staticmethod
    def run_cmd(cmd, suppress_output=False):
        stdout = subprocess.DEVNULL if suppress_output else None
        stderr = subprocess.DEVNULL if suppress_output else None
        return subprocess.run(cmd, shell=True, stdout=stdout, stderr=stderr)

    def compile_design(self):
        print("--- Cleaning and Compiling using make ---")
        self.run_cmd("make clean_all", suppress_output=False)
        comp_result = self.run_cmd("make compile", suppress_output=False)
        if comp_result.returncode != 0:
            print("\n[ERROR] Compilation Failed!")
            sys.exit(1)

    def run_simulation(self, test_name, seed, verbosity, iter_num, run_dir_name, current_time, quiet=False):
        make_sim_cmd = (
            f"make sim "
            f"TEST_NAME={test_name} "
            f"SEED={seed} "
            f"VERBOSITY={verbosity} "
            f"ITER={iter_num} "
            f"SIM_START_TIME={current_time} "
            f"RUN_DIR={run_dir_name}"
        )
        return self.run_cmd(make_sim_cmd, suppress_output=quiet)

    def merge_coverage(self):
        print("\n--- Merging Coverage ---")
        self.run_cmd("make merge_coverage", suppress_output=False)
        print("Coverage merged into total.ucdb")