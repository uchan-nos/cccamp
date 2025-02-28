#!/bin/sh

# programmer_cli.exe をラップして WSL から実行できるようにするスクリプト

if [ $# -lt 1 ]
then
  echo "Usage: $0 <mode> [<fs file>]"
  exit 1
fi

echo dirname=$(dirname $0)
. $(dirname $0)/user.env

mode="$1"
fs="$2"
fs_win="$(wslpath -w "$fs")"

cd $GWPROG_BINDIR
run_programmer="cmd.exe /C programmer_cli.exe"

if [ "$mode" = "scan" ]
then
  echo Scanning FPGA devices
  echo =====================
  $run_programmer --scan
  echo Scanning cables
  echo =====================
  $run_programmer --scan-cables
  exit 0
fi

case "$mode" in
  sram)  operation_index=2 ;;
  flash) operation_index=6 ;;
  *)     echo "available mode: sram flash scan"; exit 1 ;;
esac

$run_programmer --device GW1NR-9C --run $operation_index --fsFile "$fs_win"
