#! /bin/bash

   stty erase "^?"  #set up backspace to be erasing in tmux

if [ ! -d work ]; then
   vlib work	    #create a "work" dir
fi

if [ ! -f comp_lib.sh ]; then
   curl http://web.engr.oregonstate.edu/~traylor/ece474/inclass/wk1/comp_lib.sh > comp_lib.sh
   chmod u+x comp_lib.sh
   ./comp_lib.sh    #compiling lib gates
fi

if [  ! -f make_init.sh  -a  ! -f  makefile ]; then
   echo -e '#!/bin/bash \n vlog *.sv \n vmake > makefile\n' > make_init.sh
   chmod u+x ./make_init.sh
fi
