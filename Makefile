# =============================================================================
# Переменные путей
# =============================================================================

QUESTASIM_DIR ?= $(QUESTA_HOME)
PROJECT_DIR    = $(CURDIR)
TB_DIR         = $(PROJECT_DIR)/tb
DUT_DIR	       = $(PROJECT_DIR)/dut

# =============================================================================
# Производные переменные
# =============================================================================
UVM_SRC       = $(QUESTASIM_DIR)/verilog_src/uvm-1.2/src
UVM_DPI       = $(QUESTASIM_DIR)/uvm-1.2/win64/uvm_dpi
GCC           = $(QUESTASIM_DIR)/gcc-7.4.0-mingw64vc16/bin/gcc.exe


# =============================================================================
# Настройки симуляции
# =============================================================================
VERBOSITY = UVM_HIGH # (UVM_NONE, UVM_LOW, UVM_MEDIUM, UVM_HIGH, UVM_FULL, UVM_DEBUG)

SEED      = random


# Определения тестов и количества запусков (<имя_теста>:<количество_запусков>)
TESTS = test_lots_of_purchases:0 \
		read_after_reset_test:0 \
		full_client_session_with_no_errors:1



# =============================================================================
# Собираем все цели для симуляции
# =============================================================================

all: compile run_sims 


# Компиляция
compile:
	vlib work
	vmap work work 

	$(GCC) -shared -o \
		$(PROJECT_DIR)/c_functions.dll \
		$(PROJECT_DIR)/tb/base_classes/c_functions.c \
		-I"$(QUESTASIM_DIR)/include"
		

	vlog -sv +acc -cover f +incdir+$(UVM_SRC) \
		$(DUT_DIR)/vending_machine.sv \
		$(TB_DIR)/full_interface.sv \
		$(TB_DIR)/vm_pkg.sv \
		$(PROJECT_DIR)/top.sv




# Цели для симуляции

SIM_TARGETS =
$(foreach test,$(TESTS),$(eval SIM_TARGETS += sim_$(word 1,$(subst :, ,$(test)))))
$(foreach test,$(TESTS),$(eval sim_$(word 1,$(subst :, ,$(test))): ; @$(MAKE) sim TEST_NAME=$(word 1,$(subst :, ,$(test))) RUN_COUNT=$(word 2,$(subst :, ,$(test)))))


run_sims: start_sim $(SIM_TARGETS) merge_coverage


start_sim: 
	@echo. > errors.log
	

# Основная цель симуляции
sim:
	@for /L %%i in (1,1,$(RUN_COUNT)) do @( \
		echo Simulation #%%i start for $(TEST_NAME) & \
		@echo. > sim_log_$(strip $(TEST_NAME))_%%i.log & \
		vsim -c \
		-cvgperinstance \
		-wlf "vsim_$(strip $(TEST_NAME))_%%i.wlf" \
		-do "set NoQuitOnFinish 1; \
		log -r /*; \
		vcd file \"vsim_$(strip $(TEST_NAME))_%%i.vcd\"; \
		vcd add -r /*; \
		run -all; \
		coverage save \"ucdb_$(strip $(TEST_NAME))_%%i.ucdb\"; \
		quit -f" \
		top \
		-coverage \
		-sv_seed $(SEED) \
		-uvmtestname \
		"+UVM_TESTNAME=$(strip $(TEST_NAME))" \
		"+RUN_COUNT=%%i" \
		"+UVM_VERBOSITY=$(strip $(VERBOSITY))" \
		-sv_lib $(PROJECT_DIR)/c_functions \
		-sv_lib $(UVM_DPI) \
		-cpppath $(GCC) \
	)
	@echo "All simulations completed for $(TEST_NAME)"


# Слияние файлов покрытия
UCDB_FILES = $(wildcard ucdb_*.ucdb)
merge_coverage:
	vcover merge -testassociated -verbose -out total.ucdb $(foreach f,$(UCDB_FILES),"$(f)")


# Очистка сгенерированных файлов
clean:
	del /Q /F transcript *.wlf *.ucdb *.txt *.log *.vstf vsim_*.vlf wlf* *.dll *.vcd 2>NUL
	rmdir /S /Q work 2>NUL


help:
	@echo Usage:
	@echo "make all                             - Compile and run all simulations"
	@echo "make compile                         - Compile only"
	@echo "make run_sims                        - Run simulations and merge coverage"
	@echo "make clean                           - Clean generated files"
	@echo "make VERBOSITY=UVM_HIGH              - Override verbosity"
	@echo "make TESTS=<test_name>:<test_count>  - Override test and run count"
	@echo "make SEED=<seed_value>               - Override seed value"
	

.PHONY: all compile run_sims start_sim sim merge_coverage clean help $(SIM_TARGETS)