#!/bin/bash
set -e # script 실행 도중 에러 발생시 script 멈춤
set -o pipefail # 파이프 사용시 오류 코드(non-zero exit code)를 이어받는다

ZSH_PATH="${PWD}/zsh";
VIM_PATH="${PWD}/vim";

function check_zsh() {
    echo "-> Update ~/.zshrc ..."
    ORIGIN="${HOME}/.zshrc"
    
    if [ -f "${ORIGIN}" ]; then
      rm "${ORIGIN}"
      echo "Delete existing ~/.zshrc file"
    elif [ -L "${ORIGIN}" ]; then
      rm "${ORIGIN}"
      echo "Delete existing ~/.zshrc symlink"
    else
      echo "~/.zshrc not exists"
    fi

    ln -s "${ZSH_PATH}/.zshrc" "${ORIGIN}";
    echo "Success to put symlink of ~/.zshrc"

    echo "-> Source ~/.zshrc ..."
    zsh
    source "${HOME}/.zshrc"
    bash
}

function check_vim() {
    echo "-> Update ~/.vimrc ..."
    ORIGIN="${HOME}/.vimrc"

    if [ -f "${ORIGIN}" ]; then
      rm "${ORIGIN}"
      echo "Delete existing ~/.vimrc file"
    elif [ -L "${ORIGIN}" ]; then
      rm "${ORIGIN}"
      echo "Delete existing ~/.vimrc symlink"
    else
      echo "~/.vimrc not exists"
    fi
    
    ln -s "${VIM_PATH}/.vimrc" "${ORIGIN}";
    echo "Success to put symlink of ~/.vimrc"
    
}

function update() {
    git pull origin master

    check_zsh
    check_vim
}

# 프롬프트로 계속 진행할 것인지 물어본다.
IFS=''
greetings=("===================================" "\n"
           "livlikwav dotfiles update.sh" "\n"
           "===================================" "\n"
           "This may overwrite existing your current setting files in home dir.")
farewells=("SUCCESS" "\n"
           "===================================")

echo -e "${greetings[*]}"
read -p "Are you sure? [y/n] " yn
case $yn in
    [Yy]* )
      update
      echo -e "${farewells[*]}"
      ;; 
    * )
      echo "Not yes. close script."
      ;;
esac
