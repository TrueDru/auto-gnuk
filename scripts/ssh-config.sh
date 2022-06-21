#!/bin/bash
cat << "EOF"
         _                            __ _       
 ___ ___| |__         ___ ___  _ __  / _(_) __ _ 
/ __/ __| '_ \ _____ / __/ _ \| '_ \| |_| |/ _` |
\__ \__ \ | | |_____| (_| (_) | | | |  _| | (_| |
|___/___/_| |_|      \___\___/|_| |_|_| |_|\__, |
                                           |___/ 
EOF
read -p "Please enter the name of the server  you want to auth on with GNUK key: " host
read -p "Please enter hostname: " hostname
read -p "Please enter user: " user
echo -e "Host $host
        HostName $hostname
        User $user
        PKCS11Provider /usr/lib/opensc-pkcs11.so" >> ~/.ssh/config
echo -e "#Ssh-config was updated successfully#"
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