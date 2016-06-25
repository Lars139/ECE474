#! /bin/bash

SRC=(adder8.sv adder8.do adb)
IFS=' '

for word in ${SRC[@]}
do
   if [ -f $word ]; then
      echo " File Exist:  $word"
   else
      echo -e "\033[1;43m NOT Exist :  $word \033[0m "
      exit 0
   fi
done


