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

# install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
# run fzf install script
~/.fzf/install
# refresh zsh
source ~/.zshrc
# Notice : Vim-Plug will be auto-installed, and install plugins automatically.

# install fonts for powerline 
sudo apt-get install fonts-powerline
source ~/.zshrc

# install D2Coding Ver1.3.2-20180524
mkdir ~/.local/share/fonts
cd ~/.local/share/fonts
# Download and unpack the font archive
wget https://github.com/naver/d2codingfont/releases/download/VER1.3.2/D2Coding-Ver1.3.2-20180524.zip
unzip D2Coding-Ver1.3.2-20180524.zip
# Clear and regenerate font cache
fc-cache -f -v
# Verify the installation
fc-list | grep "D2Coding"
# Cleanup archive file
rm D2Coding-Ver1.3.2-20180524.zip

# Hands-On : Set default fonts in Terminal>Preferences>Profiles>Fonts
# Hands-On : Set symbolic link from dotfiles/.zshrc


