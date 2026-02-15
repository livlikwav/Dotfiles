# Zsh Configuration

## 개요

Source 방식으로 관리하는 Zsh 설정. oh-my-zsh + Powerlevel10k 테마 사용.

## 배포 방식

```bash
# Ansible로 자동 설정
make update
```

**자동으로 처리되는 것**:
1. ✅ oh-my-zsh 설치 (없으면)
2. ✅ Powerlevel10k 테마 설치 (없으면)
3. ✅ `~/.zshrc`에 source 라인 추가
4. ✅ 커스텀 플러그인 클론

## Terminal 앱과의 관계

### Terminal 독립적
- oh-my-zsh: 모든 터미널에서 작동
- Powerlevel10k: 모든 터미널에서 작동

### Ghostty 설정 필요
Powerlevel10k 아이콘 표시를 위해 **Nerd Font 설정 필요**:

```bash
# 1. Nerd Font 설치
brew tap homebrew/cask-fonts
brew install --cask font-meslo-lg-nerd-font

# 2. Ghostty 설정 (~/.config/ghostty/config)
font-family = "MesloLGS NF"
```

## 구조

### 모듈 시스템
`zsh/.zshrc`가 3개 모듈을 소싱:
- `.aliases` — 셸 별칭 (k8s, python, macOS 앱)
- `.env` — PATH 환경변수 (Go, uv)
- `.functions` — 사용자 정의 함수

### oh-my-zsh
- 테마: **Powerlevel10k**
- 플러그인:
  - git
  - fzf
  - zsh-syntax-highlighting (커스텀)
  - zsh-autosuggestions (커스텀)

### Powerlevel10k 설정
```bash
# Powerlevel10k 재설정
p10k configure

# 설정 파일: ~/.p10k.zsh
```

## 플러그인 추가

`ansible/group_vars/all.yml` 편집:
```yaml
zsh_plugins:
  - name: zsh-syntax-highlighting
    repo: "https://github.com/zsh-users/zsh-syntax-highlighting.git"
  - name: zsh-autosuggestions
    repo: "https://github.com/zsh-users/zsh-autosuggestions.git"
  - name: new-plugin  # 추가
    repo: "https://github.com/author/new-plugin.git"
```

그리고 `zsh/.zshrc`에 플러그인 이름 추가:
```bash
plugins=(git fzf zsh-syntax-highlighting zsh-autosuggestions new-plugin)
```

## 로컬 커스터마이징

`~/.zshrc`에 추가 설정 작성:
```bash
source ~/Dotfiles/zsh/.zshrc

# 로컬 커스텀 설정
export LOCAL_VAR="value"
alias local-alias="command"
```

## 실행 순서

```
1. Powerlevel10k instant prompt (빠른 프롬프트)
2. 모듈 로딩 (.aliases, .env, .functions)
3. oh-my-zsh 초기화
4. kubectl 자동완성
5. Powerlevel10k 설정 로드
```

## 문제 해결

### 아이콘이 깨져 보일 때
→ Ghostty에 Nerd Font 설정 확인

### oh-my-zsh 업데이트
```bash
omz update
```

### Powerlevel10k 업데이트
```bash
git -C ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k pull
```
