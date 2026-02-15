# Vim Configuration

## 개요

Source 방식으로 관리하는 Vim 설정. `~/.vimrc`에서 이 파일을 로드합니다.

## 배포 방식

```bash
# Ansible로 자동 설정
make update
```

**실행 결과**:
```vim
" ~/.vimrc (생성됨)
source ~/Dotfiles/vim/.vimrc
```

## 자동 설정

첫 Vim 실행 시 자동으로 처리:
1. ✅ vim-plug 설치 (GitHub에서 다운로드)
2. ✅ 플러그인 자동 설치
3. ✅ 설정 적용

## 구조

### vim-plug 자동 설치
- vim-plug 없으면 자동 다운로드
- 플러그인 누락 시 자동 설치 후 재로드

### 플러그인
- **vim-code-dark**: VSCode dark 컬러스킴

### 기본 설정
- 자동 들여쓰기, C 언어 들여쓰기
- 줄 번호 표시
- Tab → 4 spaces
- UTF-8 인코딩
- 상태바 표시
- 마지막 커서 위치 복원

## vim-plug 명령어

```vim
:PlugInstall   " 플러그인 설치
:PlugUpdate    " 플러그인 업데이트
:PlugUpgrade   " vim-plug 업그레이드
:PlugDiff      " 변경사항 확인
:PlugClean     " 미사용 플러그인 제거
```

## 플러그인 추가

1. `.vimrc` 편집:
   ```vim
   Plug 'author/plugin-name'
   ```
2. Vim 재시작 시 자동 설치

## 로컬 커스터마이징

`~/.vimrc`에 추가 설정 작성:
```vim
source ~/Dotfiles/vim/.vimrc

" 로컬 커스텀 설정
set relativenumber
colorscheme custom-theme
```
