# AGENTS.md

- Always respond in Korean
- 명령어 상세: `make help` 실행

## 개요

livlikwav의 개인 macOS dotfiles. Ansible로 관리, source 방식으로 배포.

## 아키텍처

**배포 방식** (Source 기반):
- `~/.zshrc`와 `~/.vimrc` 상단에 `source ~/Dotfiles/...` 추가
- Hammerspoon만 심볼릭 링크 사용

**설계 이유**:
- 머신마다 변경사항을 모두 추적하기 어려움
- 자주 변하지 않는 설정만 모듈화하여 관리
- 머신별 커스터마이징은 로컬 파일에서 유지

**Ansible 구조**:
```
ansible/
├── group_vars/all.yml    # 변수 (경로, 플러그인)
├── tasks/                # 재사용 태스크
│   ├── zsh.yml           # zsh 설정
│   ├── vim.yml           # vim 설정
│   ├── ghostty.yml       # Ghostty 설정
│   ├── brew-install.yml  # Brewfile로 패키지 설치
│   ├── backup.yml        # 백업
│   └── hammerspoon.yml   # Hammerspoon
└── playbooks/            # 진입점
    ├── update.yml        # Dotfiles 업데이트
    ├── setup.yml         # Brewfile 설치 + Ghostty 설정
    ├── backup.yml        # 백업
    └── all.yml           # 백업 + 업데이트
```

**Zsh 모듈**: `zsh/.zshrc` → `.aliases`, `.env`, `.functions` 소싱

**플러그인 추가**: `ansible/group_vars/all.yml`의 `zsh_plugins` 리스트 편집

## 중요 규칙

- `backup/`, `private/` 절대 커밋 금지 (gitignored)
- 모든 작업은 `make` 명령어 사용 (레거시 `.sh` 삭제됨)
- 저장소는 반드시 `${HOME}/Dotfiles` 경로에 위치
- Ansible 플레이북은 멱등성 보장 (여러 번 실행 안전)

## 의존성

**설치 스택**: Homebrew → pyenv → pipx → Ansible

### 새 머신 설정
```bash
# 1. 저장소 클론
git clone <repo-url> ~/Dotfiles
cd ~/Dotfiles

# 2. 부트스트랩 (Homebrew + pyenv + pipx + Ansible)
./bootstrap.sh

# 3. 터미널 재시작
exec zsh

# 4. Dotfiles 설정
make update

# 5. Health check
make doctor
```

### 기존 머신 업데이트
```bash
# Dotfiles 업데이트
make update

# 또는 백업 포함
make all
```
