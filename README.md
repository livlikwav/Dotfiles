# Dotfiles
![vimprincess](docs/vimprincess.jpg)

livlikwav의 개인 macOS dotfiles. Ansible로 관리하며 source 방식으로 배포합니다.

## 개요

**관리 도구**:
- Ansible (자동화)
- Homebrew (패키지 관리)
- pyenv (Python 버전 관리)
- pipx (Python 앱 격리 설치)

**Shell**:
- zsh (기본 셸)
- oh-my-zsh (프레임워크)
- Powerlevel10k (테마)
- 플러그인: zsh-syntax-highlighting, zsh-autosuggestions

**Editor**:
- vim-plug (플러그인 관리)
- vim-code-dark (VSCode dark 컬러스킴)

**Terminal**:
- Ghostty
- MesloLGS NF 폰트 (Nerd Font)

**Window Manager**:
- Hammerspoon (Lua 기반 자동화)

## 빠른 시작

### 새 머신 설정

```bash
# 1. 저장소 클론
git clone https://github.com/livlikwav/Dotfiles.git ~/Dotfiles
cd ~/Dotfiles

# 2. 부트스트랩 (Homebrew + pyenv + pipx + Ansible 설치)
./bootstrap.sh

# 3. 터미널 재시작
exec zsh

# 4. Dotfiles 설정 (oh-my-zsh, powerlevel10k, vim 등)
make update

# 5. 확인
make doctor
```

### 기존 머신 업데이트

```bash
cd ~/Dotfiles

# Git pull + dotfiles 업데이트
make update

# 또는 백업 포함
make all
```

## 주요 명령어

```bash
make help           # 사용 가능한 명령어 확인
make doctor         # 모든 의존성 확인
make backup         # 현재 설정 백업
make update         # Dotfiles 업데이트 (대화형)
make all            # 백업 + 업데이트
make hammerspoon    # Hammerspoon 설정
```

## 구조

```
Dotfiles/
├── bootstrap.sh           # 부트스트랩 스크립트 (의존성 설치)
├── Makefile               # 명령어 인터페이스
├── AGENTS.md              # 에이전트용 지침
├── ansible/
│   ├── group_vars/        # 공유 변수
│   ├── tasks/             # 재사용 태스크
│   └── playbooks/         # 플레이북
├── zsh/
│   ├── .zshrc             # 메인 설정
│   ├── .aliases           # 셸 별칭
│   ├── .env               # 환경변수
│   ├── .functions         # 함수
│   └── README.md
├── vim/
│   ├── .vimrc             # Vim 설정
│   └── README.md
└── hammerspoon/
    └── init.lua           # Hammerspoon 설정
```

## 배포 방식

**Source 기반**:
- `~/.zshrc` 상단에 `source ~/Dotfiles/zsh/.zshrc` 추가
- `~/.vimrc` 상단에 `source ~/Dotfiles/vim/.vimrc` 추가
- Hammerspoon만 심볼릭 링크 사용

**장점**:
- 머신별 로컬 설정 유지 가능
- 자주 변하지 않는 설정만 모듈화
- 쉬운 롤백 및 테스트

## 문서

- [AGENTS.md](./AGENTS.md) - 에이전트용 상세 지침
- [zsh/README.md](./zsh/README.md) - Zsh 설정 가이드
- [vim/README.md](./vim/README.md) - Vim 설정 가이드

## 참조

- [Homebrew](https://brew.sh/)
- [pyenv](https://github.com/pyenv/pyenv)
- [pipx](https://github.com/pypa/pipx)
- [Ansible](https://docs.ansible.com/)
- [oh-my-zsh](https://ohmyz.sh/)
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
- [Ghostty](https://ghostty.org/)
