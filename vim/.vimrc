"  ==================================================
" .vimrc of livlikwav
" ==================================================





" ==================================================
" VIM-PLUG Auto-installation
" ==================================================

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif


" ==================================================
" VIM-PLUG BLOCK
" ==================================================

" List of VIM-PLUG Commands
" :PlugInstall >> install the plugins
" :PlugUpdate >> update the plugins
" :PlugUpgrade >> update the VIM-PLUG
" :PlugDiff >> review the changes from the last :PlugUpdate
" :PlugClean >> detect and remove undeclared plugins

" Plugis will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'tomasiser/vim-code-dark' " VSCode dark colorscheme


" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" ==================================================
" BASIC SETTINGS
" ==================================================


set autoindent " set auto indent
set cindent " set C programming indent
set nu " show line number
set expandtab " change tap character to spaces
set ts=4 " set tap spaces(tapstop)
set shiftwidth=4 " set > < tap to space
set laststatus=2 " set status line to check current cursor
set statusline=\ %<%l:%v\ [%P]%=%a\ %h%m%r\ %F "set statusline formatter
set fileencodings=utf-8 " set file encoding
set title " set the window's title, reflecting the file currently being edited.

colo codedark " vscode-dark-colortheme


" Syntax Highlighting
if has("syntax")
    syntax on
endif


" set last cursor on starting vim
au BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\ exe "norm g'\"" |
\ endif


