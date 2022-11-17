#!/bin/bash

# Colors
BLACK='\033[1;30m'        # Black
RED='\033[1;31m'          # Red
GREEN='\033[1;32m'        # Green
YELLOW='\033[1;33m'       # Yellow
BLUE='\033[1;34m'         # Blue
PURPLE='\033[1;35m'       # Purple
CYAN='\033[1;36m'         # Cyan
WHITE='\033[1;37m'        # White

# vars
PROGRAMS=$(cat programs.txt)
OS=$(uname -r)


package_install () {
    for i in $PROGRAMS
    do
        echo -e "${YELLOW} --- installation de $i ---"
        sudo $1 $2 $i $3;
        echo -e "${GREEN} --- Done ---"
    done
}

copy_files () {

    cat $1 > $2
    if [ -z $3 ]; then
        cat $2
    fi

}

arch_install () {
    # update system
    sudo pacman -Syu --noconfirm

    # Install all programs listed in the txt file
    package_install pacman -Syu --noconfirm

    # Replace .zshrc
    echo -e "${YELLOW} --- Mise a jour du .zshrc ---"
    copy_files alias/.zshrc ~/.zshrc
    echo -e "${GREEN} --- Done ---"

    #.bashrc
    echo -e "${YELLOW} --- Mise a jour du .bashrc ---"
    copy_files alias/.bashrc ~/.bashrc
    echo -e "${GREEN} --- Done ---"

    echo -e "${YELLOW} --- Mise a jour des clés ssh ---"
    copy_files ssh_keys/id_rsa ~/.ssh/id_rsa ssh
    copy_files ssh_keys/id_rsa.pub ~/.ssh/id_rsa.pub ssh
    echo -e "${GREEN} --- Done ---"
}


debian_install () {

    # update system
    sudo apt update && sudo apt upgrade -y

    # Install all programs listed in the txt file
    package_install apt install -y

    # Replace .zshrc
    echo -e "${YELLOW} --- Mise a jour du .zshrc ---"
    cat alias/.zshrc > ~/.zshrc
    cat ~/.zshrc
    echo -e "${GREEN} --- Done ---"

    # Replace .bashrc
    echo -e "${YELLOW} --- Mise a jour du ..bashrc ---"
    cat alias/.bashrc > ~/.bashrc
    cat ~/.bashrc
    echo -e "${GREEN} --- Done ---"

}


arch_install