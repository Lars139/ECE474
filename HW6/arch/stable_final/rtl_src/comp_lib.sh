#!/bin/bash

#set location of synthesis library
synop_lib="/nfs/guille/a1/cadlibs/synop_lib/SAED_EDK90nm/Digital_Standard_Cell_Library/verilog"

echo "***** Compile synthesis library into work *****"
vlog $synop_lib/*  -work work



