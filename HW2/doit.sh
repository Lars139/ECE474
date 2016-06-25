#! /bin/bash

SRC=(alu.sv )
TRANSCRIPT=alu.do
MODULE=alu
SYN_SCRIPT=syn_alu01
COMP_MODE=compile_ultra
IFS=' '

#NOTE: If you want to update a makefile, 
#      you have to delete the the existing one first before execute 
#      this script

if [ -f run.report ]; then
   rm -f run.report
fi

#Take care of previous *.list
rm -f *.list

#check if the work director exists
if [ ! -d work ]; then
   echo -e "\n\033[1;34mCreating a work directory... \033[0m"
   vlib work	    #create a "work" dir
   stty erase "^?"  #set up backspace to be erasing
   echo "Done"
fi

#check if the module in lib has been compiled
if [ ! -d ./work/_temp ]; then
   #compiling modules from lib
   echo -e "\n\033[1;34mCompiling modules in the library...\033[0m"
   curl http://web.engr.oregonstate.edu/~traylor/ece474/inclass/wk1/comp_lib.sh > comp_lib.sh
   chmod u+x comp_lib.sh
   ./comp_lib.sh    #compiling lib gates
   rm -f ./comp_lib.sh
fi

#check if the rtl_src exist
if [ ! -d rtl_src ]; then
   mkdir rtl_src
fi

#check if the .synopsys_dc.setup has been imported
if [ ! -f .synopsys_dc.setup ]; then
   #compiling modules from lib
   echo -e "\n\033[1;34mCurling  .synopsys_dc.setup ... \033[0m"
   curl http://web.engr.oregonstate.edu/~traylor/ece474/inclass/wk1/.synopsys_dc.setup > .synopsys_dc.setup
fi

#check to make sure if all the file indicates in SRC exist
#if not end this script (DO NOT CONTINUE)
echo -e "\n \033[1;34mChecking the source files... \033[0m"
for word in ${SRC[@]}
do
   if [ -f ./rtl_src/$word ]; then
      echo " Source File Exist:  $word"
   else
      echo -e "\033[1;43m NOT Found :  $word \033[0m "
      echo -e "\033[1;31m makefile was not generated \033[0m "
      echo -e "\033[1;31m ... End of Bash Script ... \033[0m "
      exit 1
   fi
done

#if make file already exist, "make"
if [ -f makefile ]; then
   echo -e "\033[1;34m Make...\033[0m "
   make
else
   #First time compiling all the *.sv file
   echo -e "\n \033[1;34mCompiling the source files... \033[0m"
   vlog ./rtl_src/$MODULE.sv >> run.report 
   echo -e "\n\n____________________________________________________________________________\n\n" >> run.report

   #generate a makefile
   echo -e "\n \033[1;33mGenerating a makefile... \033[0m"
   vmake > makefile
   make
fi

#Default compiling
echo -e "\n \033[1;34mCompiling the source files... \033[0m"
vlog ./rtl_src/$MODULE.sv >> run.report 
echo -e "\n\n____________________________________________________________________________\n\n" >> run.report

#check if the transcript exists, then run vsim
#running stimulation for RTL level
echo -e "\n \033[1;34mStimulating the RTL module... \033[0m"
if [ -f $TRANSCRIPT ]; then
   cat $TRANSCRIPT  > temp_trans.do
   echo -e "write list $MODULE.list\nquit" >> temp_trans.do
   vsim $MODULE -do temp_trans.do -c -quiet -t 1ps  >> run.report
   rm -f temp_trans.do
   less $MODULE.list
else
   echo -e "\033[1;31mStimulating without a transcript \033[0m "
   exit 1
   #vsim $MODULE -c -quiet -t 1ps -novopt  >> run.report
fi
echo -e "\n\n____________________________________________________________________________\n\n" >> run.report


#running Synthesis script
if [ -f $SYN_SCRIPT ]; then
echo -e "\n \033[1;34mSynthesising... \033[0m"
   dc_shell-xg-t -f $SYN_SCRIPT >> run.report
   less $MODULE-gate.list
else
   echo -e "\033[1;43mSynthesis Script not found: $SYN_SCRIPT \033[0m "
   echo -e "\n \033[1;33mGenerating a Syn_script... \033[0m"
   echo -e "read_sverilog ./rtl_src/$MODULE.sv\n$COMP_MODE\nreport_timing\nreport_area\nwrite -format verilog -hierarchy -output $MODULE.gate.v\nquit" > $SYN_SCRIPT
echo -e "\n \033[1;34mSynthesising... \033[0m"
    dc_shell-xg-t -f $SYN_SCRIPT >> run.report
fi

echo -e "\n\n____________________________________________________________________________\n\n" >> run.report

#Gate compiling
echo -e "\n \033[1;34mCompiling to Gates... \033[0m"
vlog ./$MODULE.gate.v >> run.report 
echo -e "\n\n____________________________________________________________________________\n\n" >> run.report

#running stimulation at gate level
echo -e "\n \033[1;34mStimulating the Gates module... \033[0m\n"
if [ -f $TRANSCRIPT -a -f $MODULE.gate.v ]; then
   cat $TRANSCRIPT > temp_trans.do
   echo -e "write list $MODULE.gate.list\nquit" >> temp_trans.do
   vsim $MODULE -do temp_trans.do -c -quiet -t 1ps  >> run.report
   rm -f temp_trans.do
   less $MODULE.gate.list
else
   vsim $MODULE -c -quiet -t 1ps -novopt  >> run.report
   exit 1
   #echo -e "\033[1;31mStimulating without a transcript \033[0m "
fi

echo -e "\n\n____________________________________________________________________________\n\n" >> run.report

#check if *.list were generated
if [ ! -s $MODULE.list ]; then
   echo -e "\033[1;43mFile NOT Found: $MODULE.list\033[0m "
fi

if [ ! -s $MODULE.gate.list ]; then
   echo -e "\033[1;43mFile NOT Found: $MODULE.gate.list\033[0m "
fi

#testing w/ diff 
if [ -s $MODULE.list -a -s $MODULE.gate.list ]; then
   diff $MODULE.list $MODULE.gate.list > diff_test
   if [ ! -s diff_test ]; then
      echo -e "\033[1;33m Differece Test: \033[1;32mPASS \033[0m \n"
   else
      echo -e "\033[1;33m Differece Test: \033[1;31mFAIL \033[0m \n"
   fi
   less diff_test
   rm -f diff_test
fi

#getting rid of annoying stuff
#rm -f *.list
rm -f default.svf
rm -f vsim.wlf
rm -f command.log
rm -f transcript

#displaying the run report
#cat run.report | less

echo -e "\n______________________________END OF RUN____________________________________\n\n" >> run.report

