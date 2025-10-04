# =============================================================================
# Переменные путей (можно переопределить из командной строки)
# =============================================================================
QUESTASIM_DIR ?= C:/questasim64_2021.1
TB_DIR        ?= C:/SV/vending_machine
BASE_LIB_DIR  ?= C:/SV/vending_machine/base_classes

# =============================================================================
# Производные переменные
# =============================================================================
UVM_SRC = $(QUESTASIM_DIR)/verilog_src/uvm-1.2/src
UVM_DPI = $(QUESTASIM_DIR)/uvm-1.2/win64/uvm_dpi
GCC     = $(QUESTASIM_DIR)/gcc-7.4.0-mingw64vc16/bin/gcc.exe


# =============================================================================
# Настройки симуляции
# =============================================================================
VERBOSITY = UVM_HIGH

# =============================================================================
# Определения тестов и количества запусков
# =============================================================================
TEST_1 =test_lots_of_purchases
COUNT_TEST_1 =1
TEST_2 =add_test
COUNT_TEST_2 =0

# =============================================================================
# Собираем все цели для симуляции
# =============================================================================
SIM_TARGETS = sim_test1 sim_test2

UCDB_FILES = $(wildcard ucdb_*.ucdb)

all: compile run_sims merge_coverage

compile:
	vlib work
	vmap work work
	vlog -sv +acc +incdir+$(UVM_SRC) $(BASE_LIB_DIR)/base_pkg.sv
	vlog -sv +acc -cover f +incdir+$(UVM_SRC) +define+UVM_REG_DATA_WIDTH=32 \
		$(TB_DIR)/vending_machine.sv \
		$(TB_DIR)/full_interface.sv \
		$(TB_DIR)/vm_pkg.sv \
		$(TB_DIR)/top.sv

# =============================================================================
# Цели для запуска симуляций
# =============================================================================
run_sims: $(SIM_TARGETS)

sim_test1: compile
	@set TEST_NAME=$(TEST_1) & set RUN_COUNT=$(COUNT_TEST_1) & $(MAKE) sim

sim_test2: compile
	@set TEST_NAME=$(TEST_2) & set RUN_COUNT=$(COUNT_TEST_2) & $(MAKE) sim

sim:
	@for /L %%i in (1,1,$(RUN_COUNT)) do @( \
		echo Simulation #%%i start for $(TEST_NAME) & \
		vsim -c -cvgperinstance -wlf "vsim_$(strip $(TEST_NAME))_%%i.wlf" \
		-do "set NoQuitOnFinish 1; log -r /*; run -all; coverage save \"ucdb_$(strip $(TEST_NAME))_%%i.ucdb\"; quit -f" top \
		-coverage -sv_seed random \
		-uvmtestname \
		"+UVM_TESTNAME=$(strip $(TEST_NAME))" \
		"+UVM_VERBOSITY=$(VERBOSITY)" \
		-sv_lib $(UVM_DPI) \
		-cpppath $(GCC) \
		-logfile "sim_log_$(strip $(TEST_NAME))_%%i.txt" \
	)
	@echo "All simulations completed for $(TEST_NAME)"

merge_coverage:
	vcover merge -testassociated -verbose -out total.ucdb $(foreach f,$(UCDB_FILES),"$(f)")


clean:
	del /Q /F transcript *.wlf *.ucdb sim_log_*.txt tr_db.log vsim_stacktrace.vstf vsim_*.vlf 2>NUL
	rmdir /S /Q work 2>NUL
	

.PHONY: all sim clean sim_test1 sim_test2