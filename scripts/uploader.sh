#!/bin/bash
#Label
cat << "EOF" 
 _   _       _                 _ _             
| | | |_ __ | | ___   __ _  __| (_)_ __   __ _ 
| | | | '_ \| |/ _ \ / _` |/ _` | | '_ \ / _` |
| |_| | |_) | | (_) | (_| | (_| | | | | | (_| |
 \___/| .__/|_|\___/ \__,_|\__,_|_|_| |_|\__, |
      |_|                                |___/ 
EOF 
#Uploading
cd gnuk/src
echo -e "#Configuring GNUK#"
./configure --vidpid=234b:0000 --enable-debug >> ../../../logs/configure.log
echo -e "#Compiling GNUK with make"
build=$(make >> ../../../logs/make.log 2>&1)
if ! $build ; then
 echo -e "Something went wrong, please check logs/make.log file."
 exit 1    
fi

read -p "Do you want to upload compiled firmware? y/n: " upload 
if  [ "$upload" == "y" ]
  then
openocd -f interface/stlink.cfg -f target/stm32f1x.cfg -c 'program build/gnuk.elf verify reset exit'  
 fi

read -p "############################################################
#WARNING!!! IF YOU LOCK MEMORY YOU CAN'T UNLOCK IT LATER!!!#
############################################################
Do you want to lock stm32 memory from reading? y/n: " lock
if  [ "$lock" == "y" ]
  then
   openocd -f interface/stlink.cfg -f target/stm32f1x.cfg -c init -c "reset halt" -c "stm32f1x lock 0" -c reset -c exit   
 fi
echo "Press any key to continue..."
while [ true ] ; do
 read -t 3 -n 1
 if [ $? = 0 ] ; then
  cd ../../..
  clear
  bash ag.sh
  exit;
 fi
done