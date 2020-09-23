#!/bin/bash
# How to setup my ubuntu book

# upgrade package manager
sudo apt upgrade
sudo apt-get upgrade

# install vim
sudo apt install vim

# install zsh (ubuntu default: bash)
sudo apt-get install zsh

# set default terminal to zsh
chsh -s /usr/bin/zsh # -s --shell, set this terminal for login shell

# check that current terminal is zsh
echo $SHELL

# install oh my zsh
# https://github.com/ohmyzsh/ohmyzsh
sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install fonts

# install fzf

# set symbolic link from dotfiles/.zshrc


