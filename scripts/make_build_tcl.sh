#!/bin/sh

echo set_option -output_base_name project
echo set_device -device_version C GW1NR-LV9QN88PC6/I5
echo set_option -verilog_std sysv2017
for f in "$@"
do
  echo add_file \"$f\"
done
echo run all
