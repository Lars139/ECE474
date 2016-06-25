#! /bin/bash

SRC=(ram_addr_module.sv averager_moduel.sv ctrl_2MHz_module.sv fifo_module.sv ctrl_50MHz_module.sv shift_reg_module.sv tas.sv tb.sv)
TRANSCRIPT=dofile
MODULE=tb
IFS=' '

#NOTE: If you want to update a makefile, 
#      you have to delete the the existing one first before execute 
#      this script

if [ -f run.report ]; then
   rm -f run.report
fi

#Die you cache!
rm -f .n*
rm -f *.out

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

#check if the .synopsys_dc.setup has been imported
if [ ! -f .synopsys_dc.setup ]; then
   #compiling modules from lib
   echo -e "\n\033[1;34mCurling  .synopsys_dc.setup ... \033[0m"
   curl http://web.engr.oregonstate.edu/~traylor/ece474/inclass/wk1/.synopsys_dc.setup > .synopsys_dc.setup
fi

#check to make sure if all the file indicates in SRC exist
#if not end this script (DO NOT CONTINUE)
echo -e "\n \033[1;34mChecking the source files... \033[0m" | tee -a run.report

for word in ${SRC[@]}
do
   if [ -f ./rtl_src/$word ]; then
      echo " Source File Exist:  $word" | tee -a run.report

   else
      echo -e "\033[1;43m NOT Found :  $word \033[0m " | tee -a run.report

      echo -e "\033[1;31m makefile was not generated \033[0m " | tee -a run.report

      echo -e "\033[1;31m ... End of Bash Script ... \033[0m " | tee -a run.report

      exit 1
   fi
done

#Compiling
for word in ${SRC[@]}
do
echo -e "\n \033[1;34mCompiling $word... \033[0m" | tee -a run.report

vlog ./rtl_src/$word | tee -a run.report 
echo -e "\n\n____________________________________________________________________________\n\n"  >> run.report
done

#check if the input_file has been imported
if [ ! -f input_data ]; then
   #compiling modules from lib
   curl http://web.engr.oregonstate.edu/~traylor/ece474/14sp_hw/hw4/input_data > input_data
fi


#check if the transcript exists, then run vsim
#running stimulation 
if [ ! -f $TRANSCRIPT ]; then
   echo -e "\n \033[1;33mGenerating a transcript... \033[0m" | tee -a run.report

   #curl http://web.engr.oregonstate.edu/~traylor/ece474/14sp_hw/hw4/dofile  > $TRANSCRIPT
   echo -e "view signals\nadd wave -r /*\nrun 200000\nquit" > $TRANSCRIPT
   echo -e "\n \033[1;34mStimulating ... \033[0m" | tee -a run.report

   #vsim -novopt -do $TRANSCRIPT $MODULE -c -quiet | tee -a run.report &
   vsim -novopt -do $TRANSCRIPT $MODULE | tee -a run.report &

else
   echo -e "\n \033[1;34mStimulating ... \033[0m"
   #vsim -novopt -do $TRANSCRIPT $MODULE -c -quiet | tee -a run.report &
   vsim -novopt -do $TRANSCRIPT $MODULE | tee -a run.report &

fi
echo -e "\n\n____________________________________________________________________________\n\n" >> run.report

#use "$ vision_design <*.gate_file>" for gates layout 

if [ 1 -eq 0 ]; then #start comment

less *.out
#testing w/ diff 
if [ -s updn_cntr.out -a -s updn_cntr.traylor.out ]; then
   diff updn_cntr.out updn_cntr.traylor.out > diff_test
   if [ ! -s diff_test ]; then
      echo -e "\033[1;33m Differece Test: \033[1;32mPASS \033[0m \n"
   less diff_test
   rm -f diff_test
   else
      echo -e "\033[1;33m Differece Test: \033[1;31mFAIL \033[0m \n"
      echo -e "\n\033[1;32mI know. I know.\nSimple diff test failed.\nThe only different is in the first clock cycle (xx to 00).\nSee it for yourself in the \033[1;31mdiff_test\033[0m \033[1;32mfile \033[0m\n\n"
   less diff_test
   fi
fi

fi #end comment


#getting rid of annoying stuff
#rm -f *.list
rm -f default.svf
rm -f vsim.wlf
rm -f command.log
rm -f transcript

#displaying the run report
#cat run.report | less

echo -e "\n______________________________END OF RUN____________________________________\n\n" >> run.report

