#!/bin/bash
DISTRO=$(awk -F'=' '/^ID=/ {print tolower($2)}' /etc/*-release 2> /dev/null)
clear
echo -e "    _          ____    \n   / \        / ___|   \n  / _ \      | |  _    \n / ___ \     | |_| |   \n/_/   \_\uto  \____|nuk\nBy https://github.com/TrueDru\nDetected distro: $DISTRO"

read -p "Choose what you want to do:
1)Install gnuk
2)Compile and upload firmware to stm32
3)Compile and upload  firmware to stm32 (DFU mode)
4)Generate new ssh key on your stm32
5)Import existing key to your key
6)Exit (or leave choice empty)
>" menu

cd scripts

case $menu in
    1)
     clear
     bash gnuk-install.sh;;
    2)
     clear
     bash uploader.sh;;
    3)
     clear
     bash dfu-uploader.sh;;
    4)
     clear
     echo -e "Generating your new key..."
     if ! [ -x "$(command -v expect)" ]; then
        echo 'Error: expect is not installed. Installing expect package.' >&2
        case $DISTRO in
         manjaro | arch)
           sudo pacman -S expect >> /dev/null;;
         debian | ubuntu)
           sudo apt install -y expect >> /dev/null;;
        esac
     fi
     expect generate-ssh-key.sh
     echo -e "Key successfully generated! Welcome to the GNUK's world!";;
    5)
     clear
     bash import-key.sh;;
    6)
     exit 0;; 
esac

