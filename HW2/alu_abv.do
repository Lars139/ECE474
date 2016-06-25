view signals
add wave -r /*
add list -nodelta
configure list -strobestart {9 ns}  -strobeperiod {10 ns}
configure list -usestrobe 1

add list -notrigger -hex -width 6  -label in_a          in_a
add list -notrigger -hex -width 6  -label in_b          in_b
add list -notrigger -hex -width 8  -label opcode	opcode
add list -notrigger -hex -width 8 -label alu_out	alu_out
add list -notrigger -hex -width 10 -label alu_zero	alu_zero
add list -notrigger -hex -width 10  -label alu_carry	alu_carry

############################################################

#This is 1010_1010 against 0101_0101
force in_a  x"AA"
force in_b  x"55"

force opcode x"1"
run 10 ns

force opcode x"2"
run 10 ns

force opcode x"3"
run 10 ns

force opcode x"4"
run 10 ns

force opcode x"5"
run 10 ns

force opcode x"6"
run 10 ns

force opcode x"7"
run 10 ns

force opcode x"8"
run 10 ns

force opcode x"9"
run 10 ns

force opcode x"A"
run 10 ns

force opcode x"B"
run 10 ns

force opcode x"F"
run 10 ns 
############################################################

#This is 1111_1111 against 0000_0000
force in_a  x"00"
force in_b  x"FF"

force opcode x"1"
run 10 ns

force opcode x"2"
run 10 ns

force opcode x"3"
run 10 ns

force opcode x"4"
run 10 ns

force opcode x"5"
run 10 ns

force opcode x"6"
run 10 ns

force opcode x"7"
run 10 ns

force opcode x"8"
run 10 ns

force opcode x"9"
run 10 ns

force opcode x"A"
run 10 ns

force opcode x"B"
run 10 ns

force opcode x"F"
run 10 ns 

############################################################

#This is 1111_1111 against 1111_1111 
force in_a  x"FF" 
force in_b  x"FF" 

force opcode x"1"
run 10 ns

force opcode x"2"
run 10 ns

force opcode x"3"
run 10 ns

force opcode x"4"
run 10 ns

force opcode x"5"
run 10 ns

force opcode x"6"
run 10 ns

force opcode x"7"
run 10 ns

force opcode x"8"
run 10 ns

force opcode x"9"
run 10 ns

force opcode x"A"
run 10 ns

force opcode x"B"
run 10 ns

force opcode x"F"
run 10 ns 

