# backup local setting files
set -e # script 실행 중 에러 발생시 리턴
set -o pipefail # 파이프 사용시 오류 코드(non-zero exit code)를 이어받는다

echo "Backup config files that already exist..."

cd "${HOME}"
mkdir -p ./dotfiles/backup 

# backup zshrc
ORIGIN="./.zshrc"
if [ -f "${ORIGIN}" ]; then
  cp "${ORIGIN}" ./dotfiles/backup/.zshrc
  echo "Success to backup ~/.zshrc to ~/dotfiles/backup/.zshrc"
else
  echo ".zshrc not exists"
fi

# backup vimrc
ORIGIN="./.vimrc"
if [ -f "${ORIGIN}" ]; then
  cp "${ORIGIN}" ./dotfiles/backup/.vimrc
  echo "Success to backup ~/.vimrc to ~/dotfiles/backup/.vimrc"
else
  echo ".vimrc not exists"
fi

