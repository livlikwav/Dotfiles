# backup local setting files
set -e # script 실행 중 에러 발생시 리턴
set -o pipefail # 파이프 사용시 오류 코드(non-zero exit code)를 이어받는다

function backup_zsh() {
  echo "-> Backup already existing ~/.zshrc file"
  ORIGIN="${HOME}/.zshrc"

  if [ -f "${ORIGIN}" ]; then
    cp "${ORIGIN}" "${HOME}/dotfiles/backup/.zshrc"
    echo "Success to backup: ~/dotfiles/backup/.zshrc"
  else
    echo ".zshrc file not exists"
  fi
}

function backup_vim() {
  echo "-> Backup already existing ~/.vimrc file"
  ORIGIN="${HOME}/.vimrc"

  if [ -f "${ORIGIN}" ]; then
    cp "${ORIGIN}" "${HOME}/dotfiles/backup/.vimrc"
    echo "Success to backup: ~/dotfiles/backup/.vimrc"
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

echo "${greetings[*]}"

echo "-> Make backup dir"
mkdir -p "${HOME}/dotfiles/backup"

backup_zsh
backup_vim

echo "${farewells[*]}"


