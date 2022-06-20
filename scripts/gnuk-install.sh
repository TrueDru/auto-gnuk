#!/bin/bash
#Vars
gnuk_repo="https://salsa.debian.org/gnuk-team/gnuk/gnuk.git"
DISTRO=$(awk -F'=' '/^ID=/ {print tolower($2)}' /etc/*-release 2> /dev/null)
#Label
cat << "EOF" 
 ___           _        _ _ _                ____ _   _ _   _ _  __
|_ _|_ __  ___| |_ __ _| | (_)_ __   __ _   / ___| \ | | | | | |/ /
 | || '_ \/ __| __/ _` | | | | '_ \ / _` | | |  _|  \| | | | | ' / 
 | || | | \__ \ || (_| | | | | | | | (_| | | |_| | |\  | |_| | . \ 
|___|_| |_|___/\__\__,_|_|_|_|_| |_|\__, |  \____|_| \_|\___/|_|\_\
                                    |___/                              
EOF
#Installation
echo -e "#Clonning original GNUK repo from $gnuk_repo#"
cd scripts
yes | rm gnuk -r -R  >> /dev/null 2>&1
git clone $gnuk_repo
echo -e "#Installing requirement packages for $DISTRO#"
case $DISTRO in
 manjaro)
  sudo pacman -S arm-none-eabi-gcc arm-none-eabi-newlib openocd base-devel --noconfirm >> /dev/null;;        
esac
cd gnuk/src
echo -e "#Updating submodules#"
git submodule update --init >> /dev/null 
echo -e "#GNUK successfully installed!#"
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
