include ../../scripts/common.mk

SRCS = main.sv port.cst

all: impl/pnr/project.fs

impl/pnr/project.fs: build.tcl Makefile
	${GWSH} build.tcl

build.tcl: ${SRCS} Makefile
	${MAKE_BUILD_TCL} ${SRCS} > build.tcl

.PHONY: flash sram
flash: impl/pnr/project.fs Makefile
	${GWPROG} flash impl/pnr/project.fs

sram: impl/pnr/project.fs Makefile
	${GWPROG} sram impl/pnr/project.fs
