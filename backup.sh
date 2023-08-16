#!/bin/bash
set -e # script 실행 중 에러 발생시 리턴
set -o pipefail # 파이프 사용시 오류 코드(non-zero exit code)를 이어받는다

BACKUP_PATH="${HOME}/Dotfiles/backup";
BACKUP_ZSH_PATH="${BACKUP_PATH}/.zshrc";
BACKUP_VIM_PATH="${BACKUP_PATH}/.vimrc";

function backup_zsh() {
  echo "-> Backup already existing ~/.zshrc file"
  ORIGIN="${HOME}/.zshrc"

  if [ -f "${ORIGIN}" ]; then
    cp "${ORIGIN}" "${BACKUP_ZSH_PATH}"
    echo "Success to backup: ${BACKUP_ZSH_PATH}"
  else
    echo ".zshrc file not exists"
  fi
}

function backup_vim() {
  echo "-> Backup already existing ~/.vimrc file"
  ORIGIN="${HOME}/.vimrc"

  if [ -f "${ORIGIN}" ]; then
    cp "${ORIGIN}" "${BACKUP_VIM_PATH}"
    echo "Success to backup: ${BACKUP_VIM_PATH}"
  else
    echo ".vimrc file not exists"
  fi
}


IFS=''
greetings=("===================================" "\n"
           "livlikwav dotfiles backup.sh" "\n"
           "===================================" "\n")
farewells=("-> SUCCESS" "\n"
           "===================================")

echo -e "${greetings[*]}"

echo "-> Make backup dir"
mkdir -p "${BACKUP_PATH}"

backup_zsh
backup_vim

echo -e "${farewells[*]}"


