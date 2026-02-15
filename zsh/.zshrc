### ==================== MUST BE AT TOP ====================
# Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### ==================== Module Loading ====================
DOTFILES_PATH="${HOME}/Dotfiles"
ZSH_PATH="${DOTFILES_PATH}/zsh"

source_file() {
  if [ -f "$1" ]; then
    source "$1"
  else
    echo "Sourcing 404: $1 not found."
  fi
}

files=( "${ZSH_PATH}/.aliases" "${ZSH_PATH}/.env" "${ZSH_PATH}/.functions" )
for file in "${files[@]}"; do
  source_file $file
done

### ==================== oh-my-zsh ====================
export ZSH="${HOME}/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git fzf zsh-syntax-highlighting zsh-autosuggestions)
ZSH_DISABLE_COMPFIX="true"

source $ZSH/oh-my-zsh.sh

### ==================== Custom Configs ====================
# Kubectl autocompletion
source <(kubectl completion zsh)
complete -F __start_kubectl k

# Powerlevel10k config
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

