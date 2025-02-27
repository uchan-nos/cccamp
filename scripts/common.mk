commonmk_dir = $(dir $(lastword $(MAKEFILE_LIST)))
scripts_dir = ${commonmk_dir}

GWSH = /mnt/c/Gowin/Gowin_V1.9.10.01_x64/IDE/bin/gw_sh.exe
GWPROG = ${scripts_dir}gw_prog.sh
MAKE_BUILD_TCL = ${scripts_dir}make_build_tcl.sh
