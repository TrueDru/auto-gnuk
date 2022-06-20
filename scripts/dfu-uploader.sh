#!/bin/bash
#Label
cat << "EOF"
 ____  _____ _   _               _                 _ _             
|  _ \|  ___| | | |  _   _ _ __ | | ___   __ _  __| (_)_ __   __ _ 
| | | | |_  | | | | | | | | '_ \| |/ _ \ / _` |/ _` | | '_ \ / _` |
| |_| |  _| | |_| | | |_| | |_) | | (_) | (_| | (_| | | | | | (_| |
|____/|_|    \___/   \__,_| .__/|_|\___/ \__,_|\__,_|_|_| |_|\__, |
                          |_|                                |___/
EOF
#Uploading
cd gnuk/src
echo -e "#Configuring GNUK#"
read -p "Please, specify the target: " target

./configure --vidpid=234b:0000 --with-dfu --target $target >> ../../../logs/configure.log
echo -e "#Compiling GNUK with make"
build=$(make >> ../../../logs/make.log 2>&1)
if ! $build ; then
 echo -e "#Something went wrong, please check logs/make.log file.#"
 exit 1    
fi
echo -e "#GNUK compilation was successful#"


echo -e "Press any key to continue..."
while [ true ] ; do
 read -t 3 -n 1
 if [ $? = 0 ] ; then
  cd ../../..
  clear
  bash ag.sh
  exit;
 fi
done