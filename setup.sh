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

# Update the System
sudo pacman -Syu --noconfirm

# Install all programs listed in the txt file
for i in $PROGRAMS
do
    echo -e "${YELLOW} --- installation de $i ---"
    sudo pacman -Syu $i --noconfirm;
    echo -e "${GREEN} --- Done ---"
done

echo -e "${YELLOW} --- Mise a jour du .zshrc ---"

# Replace .zshrc
cat alias/.zshrc > ~/.zshrc
cat alias/.zshrc
echo -e "${GREEN} --- Done ---"
