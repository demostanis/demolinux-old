" useful defaults
source $VIM/vimfiles/archlinux.vim
source $VIMRUNTIME/defaults.vim

set ttymouse=xterm
set mouse=a
" tabs
set ts=2 sw=2
" highlight search
set incsearch
" wrap long lines on words
set wrap
set linebreak

" enable syntax highlighting
filetype plugin indent on
syntax on

" set correct filetype for PKGBUILDs
augroup pkgbuild
	autocmd!
	autocmd BufRead,BufNewFile PKGBUILD set ft=bash
augroup END

