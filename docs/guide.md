# Guide

## To-do

아래와 같은 과정들을 `brew bundle` 기능을 활용하면 자동화할 수 있다.  
`brew bundle`을 통해 다운받을 것들을 먼저 다 다운받고,  
`git clone`은 쉘 스크립트로 수행하고,  
준비해놓은 `zshrc`와 `vimrc`를 업데이트하면 된다.  
언제 한 번 시간내서 구현하기. <!-- https://velog.io/@iamchanii/Brewfile%EC%9D%84-%EC%9D%B4%EC%9A%A9%ED%95%B4%EC%84%9C-%ED%8C%80-%EA%B0%9C%EB%B0%9C-%ED%99%98%EA%B2%BD-%EB%A7%8C%EB%93%A4%EA%B8%B0 -->

## Step-by-step

### 0. Edit macOS preferences

- Reference
  - [link](https://subicura.com/2017/11/22/mac-os-development-environment-setup.html)

### 1. Install Homebrew

```zsh
# official site: https://brew.sh/index_ko
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# brew installation test
brew doctor
```

### 2. Install git

```zsh
brew install git # not Apple-Git. Install newest version
brew install git-lfs # Git Large File Storage for managing large binary

# git config --global
git config --global user.name "Your Name"
git config --global user.email "you@your-domain.com"
git config --global core.precomposeunicode true
git config --global core.quotepath false
```

### 3. Brew packages

```zsh
brew install python3
brew install golang
brew install fzf # fuzzy finder

brew tap "homebrew/cask"

brew cask install google-chrome
brew cask install visual-studio-code
brew cask install docker
brew cask install kubectl
brew cask install minikube
```

### 4. Install Iterm2 by brew(brew bundle)

```zsh
# official site: https://formulae.brew.sh/cask/iterm2
brew install --cask iterm2
```

### 4-2. Apply zsh-color-scheme and edit preferences

- zsh-color-scheme list
  - Snazzy.itermcolors
  - Jetbrains Darcula.itermcolors
- editing preferences reference
  - [link](https://subicura.com/2017/11/22/mac-os-development-environment-setup.html)


### 5. Update zsh and install zsh-completions

```zsh
brew install zsh zsh-completions
```

### 6. Install Oh-my-zsh

```zsh 
# offical site: https://github.com/ohmyzsh/ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### 7. Install zsh-syntax-highlighting and zsh-autosuggesions

```zsh
# zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# zsh-autosuggestions
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
```

### 8. Install oh-my-zsh theme "Powerlevel10k"

```zsh
# official site: https://github.com/romkatv/powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Powerline10k automatically install MesloLGS NF(font for dev)
p10k configure # if you finish install p10k, install wizard is automatically started
```


## Description

### Q: What is tap in brew?

tap은 Homebrew 내의 서드 파티 저장소를 말한다.
Homebrew 내의 기본 저장소는 `Formulae` 이다.

### fzf guide

- `^` + `T`: 하위 디렉토리 파일 검색
- `^` + `R`: 히스토리 검색
- `esc` + `C`: 하위 디렉토리 검색 후 이동
- `esc`: 취소