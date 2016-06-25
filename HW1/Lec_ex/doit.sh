#!/bin/bash

if [ ! -d "work" ] ; then 
  echo "work does not exist, making it"
  vlib work
fi

if [ -s "fadder.sv" ] ; then 
  vlog -novopt fadder.sv
fi

echo "***** Simulating fadder at rtl level"

vsim fadder -do fadder.do

