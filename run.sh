#!/data/data/com.termux/files/usr/bin/bash
# termux config installer.
# Author: BDhaCkers009
# Github: https://github.com/BDhaCkers009
#
set -e
# color codes
# copied from github.com/modded-ubuntu/modded-ubuntu
# package installer also copied from there.
function banner() {
    local term_width="$(tput cols)"
    local art_width=23
    local padding=$(( (term_width - art_width) / 2 ))

    echo -e "\033[32m$(printf "%${padding}s")╔╦╗┌─┐┌─┐┌┬┐┬ ┬┌─┐"
    echo -e "$(printf "%${padding}s") ║ └─┐├┤  │ │ │├─┘"
    echo -e "$(printf "%${padding}s") ╩ └─┘└─┘ ┴ └─┘┴   \033[0m"
    echo -e "\033[33m$(printf "%${padding}s")Author: \033[1;33mBDhaCkers009"
}


R="$(printf '\033[1;31m')"
G="$(printf '\033[1;32m')"
Y="$(printf '\033[1;33m')"
W="$(printf '\033[1;37m')"
C="$(printf '\033[1;36m')"
# All paths and urls

HOME_TERMUX="/data/data/com.termux/files/home"
ETC_TERMUX="/data/data/com.termux/files/usr/etc"
PRO_URL="https://raw.githubusercontent.com/BDhackers009/tsetup/main/files"

# Backuping files 
bkup_files() {
  local backup_date=$(date +%Y-%m-%d_%H:%M:%S)
  [ -f "${HOME_TERMUX}/.bashrc" ] && mv "${HOME_TERMUX}/.bashrc" "${HOME_TERMUX}/.bashrc.bak_${backup_date}"
  [ -f "${ETC_TERMUX}/inputrc" ] && mv "${ETC_TERMUX}/inputrc" "${ETC_TERMUX}/inputrc.bak_${backup_date}"
  [ -f "${HOME_TERMUX}/.termux/colors.properties" ] && mv "${HOME_TERMUX}/.termux/colors.properties" "${HOME_TERMUX}/.termux/colors.properties.bak_${backup_date}"
  [ -f "${HOME_TERMUX}/.termux/font.ttf" ] && mv "${HOME_TERMUX}/.termux/font.ttf" "${HOME_TERMUX}/.termux/font.ttf.bak_${backup_date}"
  [ -f "${HOME_TERMUX}/.termux/termux.properties" ] && mv "${HOME_TERMUX}/.termux/termux.properties" "${HOME_TERMUX}/.termux/termux.properties.bak_${backup_date}"
}

pkg_install() {
# update and upgrade
yes | pkg up

# Install required packages.

pkgs=(git fd ripgrep perl fzf exa bat xz-utils ncurses-utils)

for pro in "${pkgs[@]}"; do
    type -p "$pro" &>/dev/null || {
        echo -e "\n${R} [${W}-${R}]${G} Installing package : ${Y}$pro${W}"
        yes | pkg install "$pro"
    }
done
}

# downloading required files 

#!/bin/bash

# Define the URLs for the files
setup_files() {
urls=(
    "https://raw.githubusercontent.com/BDhackers009/tsetup/main/files/.bashrc"
    "https://raw.githubusercontent.com/BDhackers009/tsetup/main/files/inputrc"
    "https://raw.githubusercontent.com/BDhackers009/tsetup/main/files/colors.properties"
    "https://raw.githubusercontent.com/BDhackers009/tsetup/main/files/font.ttf"
    "https://raw.githubusercontent.com/BDhackers009/tsetup/main/files/termux.properties"
)

# Define the local paths for the files
paths=(
    "$HOME_TERMUX/.bashrc"
    "$ETC_TERMUX/inputrc"
    "$HOME_TERMUX/.termux/colors.properties"
    "$HOME_TERMUX/.termux/font.ttf"
    "$HOME_TERMUX/.termux/termux.properties"
)

# Loop over the URLs and paths and download each file
for i in ${!urls[@]}; do
    echo "Downloading ${urls[$i]} to ${paths[$i]}..."
    curl -sSfL "${urls[$i]}" -o "${paths[$i]}"
done
}

all_done() {
  clear
  banner
  echo 
  echo "[+] Termux has been setup successfully. Now Restart Termux and Enjoy."
  termux-reload-settings
}



main() {
  pkg_install
  sleep 0.3
  bkup_files
  sleep 0.3
  setup_files
  sleep 0.3
  all_done
}

main
