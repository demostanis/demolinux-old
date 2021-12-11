" useful defaults
source $VIM/vimfiles/archlinux.vim
source $VIMRUNTIME/defaults.vim

" tabs
set ts=2 sw=2
" highlight search
set incsearch

" enable syntax highlighting
filetype plugin indent on
syntax on

" set correct filetype for PKGBUILDs
augroup pkgbuild
	autocmd!
	autocmd BufRead,BufNewFile PKGBUILD set ft=bash
augroup END

