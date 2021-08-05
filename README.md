# Dotfiles
![vimprincess](docs/vimprincess.jpg)

My private macOS dotfiles.

## overview

- ~~brew bundle~~
- homebrew
  - git
  - git-lfs
  - fzf
  - python3
  - golang
- brew cask
  - google-chrome
  - ~~docker~~
  - ~~visual-studio-code~~
  - kubectl
  - minikube
- iterm2
  - color-scheme
- zsh
  - zsh-completions
  - oh-my-zsh
    - zsh-autosuggestions
    - zsh-syntax-highlighting
    - theme "Powerlevel10k"
      - dev font "MesloLGS NF"
- vim
  - vim-plug
  - VSCode dark colorscheme

## Getting-started

### Pre-requisite

Follow [this!](./docs/guide.md)  
-> Install packages

### Update dotfiles

```bash

chmod +x backup.sh
chmod +x update.sh

# backup configs first
./backup.sh

# copy dotfiles to ~
./update.sh

```
