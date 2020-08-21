# backup local setting files
set -e
set -o pipefail

cd "$(dirname "${BASH_SOURCE}")";

echo "Do backup local configs ... "

# copy vimrc and zshrc
cp ~/.vimrc ./backup/.vimrc
cp ~/.zshrc ./backup/.zshrc







