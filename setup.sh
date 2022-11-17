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

arch_install () {

    # update system
    sudo pacman -Syu --noconfirm

    # Install all programs listed in the txt file
    package_install pacman -Syu --noconfirm

    echo -e "${YELLOW} --- Mise a jour du .zshrc ---"

    # Replace .zshrc
    cat alias/.zshrc > ~/.zshrc
    cat ~/.zshrc
    echo -e "${GREEN} --- Done ---"

}


debian_install () {

    # update system
    sudo apt update && sudo apt upgrade -y

    # Install all programs listed in the txt file
    package_install apt install -y

    echo -e "${YELLOW} --- Mise a jour du .zshrc ---"

    # Replace .zshrc
    cat alias/.zshrc > ~/.zshrc
    cat ~/.zshrc
    echo -e "${GREEN} --- Done ---"

}

arch_install