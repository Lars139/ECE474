add list -nodelta
configure list -strobestart {9 ns}  -strobeperiod {10 ns}
configure list -usestrobe 1

add list -notrigger -hex -width 4  -label a          a
add list -notrigger -hex -width 4  -label b          b
add list -notrigger -hex -width 10 -label sum_out    sum_out
add list -notrigger -hex -width 8  -label c_out      c_out

force a  x"00"
force b  x"00"
run 10 ns

force a  x"00"
force b  x"FF"
run 10 ns

force a  x"FF"
force b  x"00"
run 10 ns

force a  x"FF"
force b  x"FF"
run 10 ns

force a  x"0F"
force b  x"00"
run 10 ns

force a  x"F0"
force b  x"00"
run 10 ns

force a  x"00"
force b  x"0F"
run 10 ns

force a  x"00"
force b  x"F0"
run 10 ns

force a  x"0F"
force b  x"0F"
run 10 ns

force a  x"F0"
force b  x"0F"
run 10 ns

force a  x"F0"
force b  x"F0"
run 10 ns

force a  x"F0"
force b  x"FF"
run 10 ns

force a  x"0F"
force b  x"FF"
run 10 ns

force a  x"FF"
force b  x"0F"
run 10 ns

force a  x"FF"
force b  x"F0"
run 10 ns

force a  x"08"
force b  x"00"
run 10 ns

force a  x"80"
force b  x"00"
run 10 ns

force a  x"00"
force b  x"08"
run 10 ns

force a  x"00"
force b  x"80"
run 10 ns

force a  x"50"
force b  x"50"
run 10 ns

#Bash script will edit this part for RTL and gate lvl
#write list adder8.list
#quit
