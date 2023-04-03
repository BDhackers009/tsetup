#!/bin/bash
# STORAGE setup
if [[ ! -d $HOME_TURMAX/storage ]];then
  termux-setup-storage
fi
# Update and Upgrades

yes | pkg up

# Install packages

yes | pkg i fzf bat perl exa git bash-completion fd ripgrep

# Setup bashrc and inputrc
HOME_TURMAX="/data/data/com.termux/files/home"
ETC_TURMAX="/data/data/com.termux/files/usr/etc"
BASHRC="/data/data/com.termux/files/home/.bashrc"
BASHRC_PRO="/sdcard/.bashrc"
INPUTRC="/data/data/com.termux/files/usr/etc/inputrc"
INPUTRC_PRO="/sdcard/inputrc"
if [[ -f $BASHRC ]];then
  mv $BASHRC $HOME_TURMAX/.bashrc.bak
  cp $BASHRC_PRO $HOME_TURMAX
else
  cp $BASHRC_PRO $HOME_TURMAX
fi

if [[ -f $INPUTRC ]];then
  mv $INPUTRC $ETC_TURMAX/inputrc.bak
  cp $INPUTRC_PRO $ETC_TURMAX
else
  cp $INPUTRC_PRO $ETC_TURMAX
fi
if [[ -f $HOME_TURMAX/.termux/termux.properties ]];then
  mv $HOME_TURMAX/.termux/termux.properties $HOME_TURMAX/.termux/termux.properties.bak
  cp /sdcard/termux.properties $HOME_TURMAX/.termux/
else
  cp /sdcard/termux.properties $HOME_TURMAX/.termux
fi

if [[ -f $HOME_TURMAX/.termux/color.properties ]];then
  mv $HOME_TURMAX/.termux/color.properties $HOME_TURMAX/.termux/color.properties.bak
cp /sdcard/color.properties $HOME_TURMAX/.termux/color.properties
else
  cp /sdcard/color.properties $HOME_TURMAX/.termux/color.properties
fi

if [[ -f $HOME_TURMAX/.termux/font.ttf ]];then
  mv $HOME_TURMAX/.termux/font.ttf $HOME_TURMAX/.termux/font.ttf.bak
cp /sdcard/font.ttf $HOME_TURMAX/.termux
else
cp /sdcard/font.ttf $HOME_TURMAX/.termux
fi

if [[ $? = "0" ]];then
  echo "Setup successfully."
else
  echo "Error occured.."
fi
