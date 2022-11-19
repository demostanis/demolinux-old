" useful defaults
source $VIMRUNTIME/defaults.vim

colorscheme habamax

filetype plugin indent on
syntax on

set ttymouse=xterm
set mouse=a
" tabs
set ts=2 sw=2
" highlight search
set incsearch
" wrap long lines on words
set wrap
set linebreak
set number
set relativenumber
" always show the leftmost column (which contains LSP errors and warnings),
" instead of making the whole buffer shift when you correct an error
set signcolumn=yes

" show tabs as dots
set list
set listchars=tab:··
highlight SpecialKey ctermfg=8
hi MatchParen cterm=none

nnoremap gI ^
nnoremap U <c-r>

let mapleader = " "
nnoremap <space> <nop>

augroup pkgbuild
	autocmd!
	autocmd BufRead,BufNewFile PKGBUILD set ft=bash
augroup END

augroup help
	" this makes $ go to the actual word, instead of an empty character
	function! Gotolastword()
		normal! $
		if col('.') == len(getline('.'))
			normal! h
		endif
	endfunction

	autocmd!
	autocmd FileType help nnoremap <cr> <c-]>
	autocmd Filetype help nnoremap <silent> <buffer> $ :call Gotolastword()<cr>
augroup END

augroup packageslist
	autocmd!
	autocmd BufWrite packages.x86_64 %!sort
augroup END

augroup lsp_install
	function! s:on_lsp_buffer_enabled() abort
		setlocal omnifunc=lsp#complete
		nmap <buffer> gd <plug>(lsp-definition)
		nmap <buffer> gr <plug>(lsp-references)
		nmap <buffer> gs <plug>(lsp-document-symbol-search)
		nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
		nmap <buffer> K <plug>(lsp-hover)
		nmap <buffer> [g <plug>(lsp-previous-diagnostic)
		nmap <buffer> ]g <plug>(lsp-next-diagnostic)
		nmap <buffer> cn <plug>(lsp-rename)
		nmap <buffer> sd <plug>(lsp-document-diagnostics)
		nmap <buffer> sA <plug>(lsp-code-action)
		nnoremap <buffer> <expr> <c-f> lsp#can_scroll() ? lsp#scroll(+4) : "\<c-f>"
		nnoremap <buffer> <expr> <c-b> lsp#can_scroll() ? lsp#scroll(-4) : "\<c-b>"
	endfunction

	function! s:close_if_no_diagnostics() abort
		let s:v = values(lsp#get_buffer_diagnostics_counts())
		let s:any = 0
		for s:t in s:v
			let s:any += s:t
		endfor
		if s:any == 0
			silent! lclose
		endif
	endfunction

	autocmd!
	autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
	autocmd User lsp_diagnostics_updated call s:close_if_no_diagnostics()
	
	function! s:icon(icon)
		return {'text': a:icon.' '}
	endfunction
	let g:lsp_diagnostics_signs_error = s:icon('')
	let g:lsp_diagnostics_signs_warning = s:icon('')
	let g:lsp_diagnostics_signs_information = s:icon('')
	let g:lsp_diagnostics_signs_hint = s:icon('')
	let g:lsp_document_code_actions_signs_hint = s:icon('')

	highlight LspErrorText ctermfg=red ctermbg=none
	highlight LspWarningText ctermfg=yellow ctermbg=none
augroup END

" use tabs to navigate through g{s,S} results
autocmd FileType lsp-quickpick-filter imap <expr> <buffer> <Tab> "\<C-n>"
autocmd FileType lsp-quickpick-filter imap <expr> <buffer> <S-Tab> "\<C-p>"

inoremap <expr> <tab> pumvisible() ?  "\<c-n>" : "\<tab>"
inoremap <expr> <s-tab> pumvisible() ?  "\<c-p>" : "\<s-tab>"
inoremap <expr> <cr> pumvisible() ? asyncomplete#close_popup() : "\<cr>"

inoremap <expr> <c-j> vsnip#available(1) ?  "\<plug>(vsnip-expand-or-jump)" : "\<c-j>"

" that's need by fzf so we can press <esc> without waiting ttimeoutlen
set ttimeout notimeout ttimeoutlen=0
" pickers, powered by fzf
nmap <leader>f :Files<cr>
nmap <leader>b :Buffers<cr>
nmap <leader>g :Rg<cr>
nmap <leader>w :Windows<cr>

" use s and S instead of ys and yS to surround
nmap s <Plug>Ysurround
nmap S <Plug>YSurround
nmap ss <Plug>Yssurround
nmap SS <Plug>YSsurround

let g:airline_section_y = ''
let g:airline_section_z = '%p%% %l.%c/%L'
let g:airline_powerline_fonts = 1
au VimEnter * AirlineTheme minimalist
" if we set the theme after setting the variable below,
" there is a weird bug where the mode is hidden
let g:airline_skip_empty_sections = 1
au VimEnter * AirlineRefresh
set noshowmode

nmap <leader>t :NERDTreeToggle<cr>
" start NERDTree when Vim starts with a directory argument
" (stolen from the README)
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
			\ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

function! WindowMode()
	call submode#enter_with('window', 'n', '', '<leader>W')
	call submode#leave_with('window', 'n', '', '<esc>')
	call submode#map('window', 'n', 'x', 'v', '<c-w>v')
	call submode#map('window', 'n', 'x', 'n', '<c-w>n')
	call submode#map('window', 'n', '', 'h', '<c-w>h')
	call submode#map('window', 'n', '', 'j', '<c-w>j')
	call submode#map('window', 'n', '', 'k', '<c-w>k')
	call submode#map('window', 'n', '', 'l', '<c-w>l')
	call submode#map('window', 'n', '', 'H', '<c-w>H')
	call submode#map('window', 'n', '', 'J', '<c-w>J')
	call submode#map('window', 'n', '', 'K', '<c-w>K')
	call submode#map('window', 'n', '', 'L', '<c-w>L')
	call submode#map('window', 'n', '', 'r', '<c-w>r')
	call submode#map('window', 'n', '', 'R', '<c-w>R')
	call submode#map('window', 'n', '', 'h', '<c-w>+')
	call submode#map('window', 'n', '', 'H', '<c-w>-')
	call submode#map('window', 'n', '', 'w', '<c-w>>')
	call submode#map('window', 'n', '', 'W', '<c-w><')
endfunction
au VimEnter * call WindowMode()

" plugin management shortcuts
nmap <leader>pi :PlugInstall<cr>
nmap <leader>ps :PlugStatus<cr>
nmap <leader>pu :PlugUpdate<cr>

nmap <leader>R :source ~/.vimrc<cr>
