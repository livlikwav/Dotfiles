" ==================================================
" VIM-PLUG 자동 설치
" ==================================================
" vim-plug가 없으면 설치
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" 누락된 플러그인이 있으면 자동 설치
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" ==================================================
" VIM-PLUG 플러그인
" ==================================================
" VIM-PLUG 명령어 목록
" :PlugInstall >> 플러그인 설치
" :PlugUpdate >> 플러그인 업데이트
" :PlugUpgrade >> VIM-PLUG 업그레이드
" :PlugDiff >> 마지막 :PlugUpdate 변경사항 확인
" :PlugClean >> 선언되지 않은 플러그인 제거
" 플러그인이 다운로드될 디렉토리 지정
call plug#begin('~/.vim/plugged')

" 플러그인 목록
Plug 'tomasiser/vim-code-dark' " VSCode dark 컬러스킴

" 플러그인 목록 종료
call plug#end()

" ==================================================
" 기본 설정
" ==================================================
set autoindent " 자동 들여쓰기
set cindent " C 언어 들여쓰기
set nu " 줄 번호 표시
set expandtab " Tab을 스페이스로 변환
set ts=4 " Tab 크기 (tabstop)
set shiftwidth=4 " >> << 들여쓰기 크기
set laststatus=2 " 항상 상태바 표시
set statusline=\ %<%l:%v\ [%P]%=%a\ %h%m%r\ %F " 상태바 포맷
set fileencodings=utf-8 " 파일 인코딩
set title " 윈도우 타이틀에 현재 편집 중인 파일 표시
colo codedark " VSCode dark 테마

" 문법 하이라이팅
if has("syntax")
    syntax on
endif

" Vim 시작 시 마지막 커서 위치 복원
au BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\ exe "norm g'\"" |
\ endif
