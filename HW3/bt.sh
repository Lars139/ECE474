#! /bin/bash

rm -f .ns*
vlog tb_skel.sv
vsim tb -do dofile.do -c -quiet
cat *.out
