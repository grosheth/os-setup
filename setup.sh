#!/bin/bash

# Colors
BLACK='\033[1;30m'        # Black
RED='\033[1;31m'          # Red
GREEN='\033[1;32m'        # Green
YELLOW='\033[1;33m'       # Yellow
BLUE='\033[1;34m'         # Blue
CYAN='\033[1;36m'         # Cyan
WHITE='\033[1;37m'        # White
LIGHT_GREEN='\033[0;32m'        # Green

# vars
PROGRAMS=$(cat programs.txt)
OS=$(uname -r)
USERS=$(ls /home)


package_install () {
    for i in $PROGRAMS
    do
        echo -e "${YELLOW} --- installation de $i ---"
        sudo $1 $2 $i $3;
        echo -e "${GREEN} --- Done ---"
    done
}

shell_command () {
    {
        RETURN_CODE=$($*)
    } &> /dev/null
    CMD_RETURN_CODE=$?

    if [ $CMD_RETURN_CODE == 1 ]; then
        echo -e "${RED}"
        echo $*
    else
        echo -e "${LIGHT_GREEN}"
        echo $*
    fi
}

arch_install () {
    # update system
    sudo pacman -Syu --noconfirm
    #Install all programs listed in the txt file
    package_install pacman -Syu --noconfirm
    common_install
}


debian_install () {
    # update system
    sudo apt update && sudo apt upgrade -y
    # Install all programs listed in the txt file
    package_install apt install -y
    common_install
}

common_install() {
    # .zshrc
    echo -e "${YELLOW} --- Mise a jour du .zshrc ---${LIGHT_GREEN}"
    shell_command cat files/.zshrc ~/.zshrc
    echo -e "${GREEN} --- Done ---"
    # .bashrc
    echo -e "${YELLOW} --- Mise a jour du .bashrc ---${LIGHT_GREEN}"
    shell_command cat files/.bashrc ~/.bashrc
    echo -e "${GREEN} --- Done ---"
    # .Bookmarks
    echo -e "${YELLOW} --- Mise a jour des bookmarks Brave ---${LIGHT_GREEN}"
    shell_command cat files/Bookmarks ~/.config/BraveSoftware/Brave-Browser/Default/Bookmarks
    echo -e "${GREEN} --- Done ---"
    # .Bookmarks
    echo -e "${YELLOW} --- Mise a jour des bookmarks Chrome ---${LIGHT_GREEN}"
    shell_command cat files/Bookmarks ~/.config/google-chrome/Default/Bookmarks
    shell_command cat files/Bookmarks ~/.config/chromium/Default/Bookmarks
    echo -e "${GREEN} --- Done ---"

    echo -e "${YELLOW} --- Mise a jour des clées ssh ---${LIGHT_GREEN}"
    shell_command cat ssh_keys/id_rsa ~/.ssh/id_rsa
    shell_command cat ssh_keys/id_rsa.pub ~/.ssh/id_rsa.pub
    echo -e "${GREEN} --- Done ---"
    # Konsole
    echo -e "${YELLOW} --- Ajout des config Konsole ---${LIGHT_GREEN}"
    for i in $USERS
    do
        shell_command cp -r files/konsole /home/$i/.local/share/konsole
        shell_command chown -R $i /home/$i/.local/share/konsole
    done
    echo -e "${GREEN} --- Done ---"
}

if grep -q "arch" <<< "$OS"; then
  echo -e "${CYAN} Your system is $OS"
  sleep 2
  arch_install
fi

if grep -q "debian" <<< "$OS"; then
  echo -e "${CYAN} Your system is $OS"
  sleep 2
  debian_install
fi

echo -e "${CYAN} --- Installation done ---"
