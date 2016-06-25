#! /bin/bash

if [ ! -d work ]; then
	vlib work
fi

#vlog *.sv

#we can replace "vlog *.sv" w/ make after you use "vmake > makefile"
make
