# =============================================================================
# Автоопределение ОС и настройка платформозависимых переменных
# =============================================================================
ifeq ($(OS),Windows_NT)
    # Настройки для Windows
    DLL_EXT      := dll
    DPI_OS_DIR   := win64
    CFLAGS       := -shared
    RM           := del /Q /F
    RMDIR        := rmdir /S /Q
    # Команда создания библиотеки, если её нет
    CREATE_WORK  := if not exist work vlib work
    # Игнорирование ошибок удаления (в Windows del падает, если файлов нет)
    SUB_ERR      := 2>NUL || rem
else
    # Настройки для Linux
    DLL_EXT      := so
    DPI_OS_DIR   := linux_x86_64
    CFLAGS       := -shared -fPIC
    RM           := rm -f
    RMDIR        := rm -rf
    CREATE_WORK  := vlib work
    SUB_ERR      := 2>/dev/null || true
endif

# =============================================================================
# Переменные путей
# =============================================================================
QUESTASIM_DIR ?= $(QUESTA_HOME)

PROJECT_DIR   := $(CURDIR)/..
TB_DIR        := $(PROJECT_DIR)/tb
DUT_DIR       := $(PROJECT_DIR)/dut
SIM_DIR       := $(PROJECT_DIR)/sim

TOP_MODULE    ?= top
DUT_MODULE    ?= vending_machine.sv
TB_PKG        ?= vm_pkg.sv

UVM_SRC        = $(QUESTASIM_DIR)/verilog_src/uvm-1.2/src
UVM_DPI        = $(QUESTASIM_DIR)/uvm-1.2/$(DPI_OS_DIR)/uvm_dpi

C_DLL          = $(SIM_DIR)/work/c_functions.$(DLL_EXT)
C_SRC          = $(TB_DIR)/uvm_base_classes/c_functions.c

# Переменные от Python
TEST_NAME     ?= base_test
SEED          ?= random
VERBOSITY     ?= UVM_LOW
ITER          ?= 1

# =============================================================================
# Правила сборки (одинаковые для всех ОС)
# =============================================================================

all: compile sim

pre_compile:
	@$(CREATE_WORK)

$(C_DLL): $(C_SRC) pre_compile
	gcc $(CFLAGS) -o $@ $< -I"$(QUESTASIM_DIR)/include"

compile: pre_compile $(C_DLL)
	vlog -sv +acc -cover f +incdir+$(UVM_SRC) \
		$(DUT_DIR)/$(DUT_MODULE) \
		$(TB_DIR)/$(TB_PKG) \
		$(TB_DIR)/$(TOP_MODULE).sv \
		+define+USE_C_FUNCTIONS \
		+define+USE_CUSTOM_REPORT_SERVER

sim:
	vsim -c \
		-cvgperinstance \
		-wlf "vsim_$(TEST_NAME)_$(ITER).wlf" \
		-do "set NoQuitOnFinish 1; log -r /*; vcd file vsim_$(TEST_NAME)_$(ITER).vcd; vcd add -r /*; run -all; coverage save ucdb_$(TEST_NAME)_$(ITER).ucdb; quit -f" \
		$(TOP_MODULE) \
		-coverage \
		-sv_seed $(SEED) \
		"+UVM_TESTNAME=$(TEST_NAME)" \
		"+RUN_COUNT=$(ITER)" \
		"+UVM_VERBOSITY=$(VERBOSITY)" \
		-sv_lib work/c_functions \
		-sv_lib $(UVM_DPI)

merge_coverage:
	vcover merge -testassociated -verbose -out total.ucdb *.ucdb

clean:
	-$(RM) transcript *.wlf *.ucdb *.log *.vcd total.ucdb $(SUB_ERR)

clean_all: clean
	-$(RMDIR) work $(SUB_ERR)

.PHONY: all pre_compile compile sim merge_coverage clean clean_all