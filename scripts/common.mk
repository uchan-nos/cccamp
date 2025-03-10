# Verilog のビルドで共通に用いる機能を定義する

commonmk_dir = $(patsubst %/,%,$(dir $(lastword $(MAKEFILE_LIST))))
scripts_dir = $(commonmk_dir)

include $(scripts_dir)/user.env

GWSH = $(GWIDE_BINDIR)/gw_sh.exe
GWPROG = $(scripts_dir)/gw_prog.sh
MAKE_BUILD_TCL = $(scripts_dir)/make_build_tcl.sh

SRCS_HDL = $(filter %.v %.sv,$(SRCS))

all: impl/pnr/project.fs

impl/pnr/project.fs: build.tcl Makefile
	$(GWSH) build.tcl

build.tcl: $(SRCS) Makefile
	$(MAKE_BUILD_TCL) $(SRCS) > build.tcl

sim.exe: $(TESTBENCH) $(SRCS_HDL) Makefile
	iverilog -g2012 -o $@ $(TESTBENCH) $(SRCS_HDL)

.PHONY: flash sram clean sim
flash: impl/pnr/project.fs Makefile
	$(GWPROG) flash impl/pnr/project.fs

sram: impl/pnr/project.fs Makefile
	$(GWPROG) sram impl/pnr/project.fs

clean: Makefile
	rm -rf build.tcl impl sim.exe

sim: sim.exe Makefile
	./sim.exe
