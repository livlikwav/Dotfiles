# AGENTS.md

이 파일은 이 저장소에서 작업할 때 Agent 에게 지침을 제공합니다.

## 개요

livlikwav의 개인 macOS dotfiles입니다. `~/Dotfiles`에서 `$HOME`으로 심볼릭 링크를 통해 zsh, vim, Hammerspoon 설정을 관리합니다.

## 주요 명령어

```bash
# 현재 ~/.zshrc와 ~/.vimrc를 backup/ 디렉토리로 백업
./backup.sh

# 최신 버전을 pull하고 dotfiles를 $HOME에 심볼릭 링크 (대화형, 확인 요청)
./update.sh

# Ansible을 통해 Hammerspoon 설정 심볼릭 링크 생성
make hammerspoon

# Ansible 설치 여부 확인
make ansible-check
```

## 아키텍처

**배포 모델**: `update.sh`는 `$HOME/.zshrc` → `zsh/.zshrc` 및 `$HOME/.vimrc` → `vim/.vimrc`로 심볼릭 링크를 생성합니다. Hammerspoon은 Ansible(`make hammerspoon`)을 사용하여 `hammerspoon/init.lua` → `~/.hammerspoon/init.lua`로 심볼릭 링크를 생성합니다.

**Zsh 모듈 시스템**: `zsh/.zshrc`는 `zsh/`의 세 가지 모듈 파일을 소싱합니다:
- `.aliases` — 셸 별칭 (k8s, python, macOS 앱)
- `.env` — PATH 내보내기 (Go, uv)
- `.functions` — 사용자 정의 셸 함수

`.zshrc`의 `DOTFILES_PATH` 상수는 `${HOME}/Dotfiles`로 하드코딩되어 있으므로 저장소가 해당 경로에 있어야 합니다.

**Zsh 스택**: Powerlevel10k 테마를 사용하는 oh-my-zsh, 플러그인: git, fzf, zsh-syntax-highlighting, zsh-autosuggestions. `update.sh`가 커스텀 플러그인 클론을 처리합니다.

**Hammerspoon**: `hammerspoon/init.lua`는 하이퍼 키(cmd+alt+shift+ctrl) 앱 런처를 정의합니다. `.lua` 파일 변경 시 자동으로 다시 로드됩니다.

## 중요한 규칙

- `backup/` 및 `private/` 디렉토리는 gitignore되어 있으며 절대 커밋하면 안 됩니다.
- 셸 스크립트는 `set -e`와 `set -o pipefail`을 사용합니다.
- `update.sh`는 저장소 루트에서 실행해야 합니다 (심볼릭 링크 소스에 `$PWD` 사용).
