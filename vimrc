"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"               /\/|  __              _
"              |/\/  / /     __   __ (_)  _ __ ___  _ __ ___
"                   / /      \ \ / / | | | '_ ` _ \| '__/ __|
"                  / /    _   \ V /  | | | | | | | | | | (__
"                 /_/    (_)   \_/   |_| |_| |_| |_|_|  \___|        *Portable
"
"   Maintainer: Jose Elera (https://github.com/jelera)
"               http://www.twitter.com/jelera
"
" Last Updated: Sun 02 Nov 2014 11:15:51 PM CST
"
"        Notes: This is my vimrc for remote Linux/BSD boxes. It is portable
"               and somewhat lightweight yet featureful
"
"   Disclaimer: You are welcome to take a look at my .vimrc and take ideas in
"               how to customize your Vim experience; though I encourage you
"               to experiment with your own mappings, plugins and configs.
"
"      License: MIT
"               Copyright (c) 2014 Jose Elera Campana
"
"               Permission is hereby granted, free of charge, to any person
"               obtaining a copy of this software and associated documentation
"               files (the "Software"), to deal in the Software without
"               restriction, including without limitation the rights to use,
"               copy, modify, merge, publish, distribute, sublicense, and/or
"               sell copies of the Software, and to permit persons to whom the
"               Software is furnished to do so, subject to the following
"               conditions:
"
"               The above copyright notice and this permission notice shall be
"               included in all copies or substantial portions of the
"               Software.
"
"               THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
"               KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
"               WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
"               PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
"               COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
"               LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
"               OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"               SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins:                                                                    "
"    Pathogen.vim       - Plugin management                                   "
"    unimpaired.vim     - Good Mapping to navigate around Vim                 "
"    vim-commentary     - Lightweight commenting keymaps                      "
"    vim-fugitive       - Git interface for Vim                               "
"    vim-surround       - Smart surrounding of quotes, brackets, tags, etc.   "
"    vim-eunuch         - Vim sugar for UNIX commands                         "
"    vim-signify        - VCS feedback next to the edited lines               "
"    vim-tmux-navigator - TMUX/Vim keybindings                                "
"    vim-lightline      - Lightweight statusline                              "
"    Neocomplcache      - Autocompletion engine                               "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"----------------------------------------------------------------------------//
" => PATHOGEN
"----------------------------------------------------------------------------//
set nocompatible
execute pathogen#infect()
syntax on
filetype plugin indent on


"----------------------------------------------------------------------------//
" => GENERAL SETTINGS
"----------------------------------------------------------------------------//
exec "set path=".expand("$PATH")

set laststatus=2
set backspace=indent,eol,start
set matchpairs+=<:>
set encoding=utf-8
set fileformats=unix,mac,dos
set fileformat=unix
set cmdheight=2
set iskeyword+=_,$,@,%,#
set autoread
set mousehide
set viminfo='1000,f1,:1000,/1000,<1000,s100
set history=1000
set undolevels=1000
set confirm
set shiftround
set noswapfile

"[  SEARCH  ]---------------------------"
set hlsearch
set incsearch
set ignorecase
set smartcase

"[  UNDO  ]-----------------------------"
if version >= 730
	set undofile
	set undolevels=999
endif

"[  WILD MENU  ]------------------------"
set wildmenu
set wildignore=.svn,CVS,.git,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp
set wildmode=full
set completeopt=menu,menuone,longest

"[  LEADER  ]---------------------------"
let mapleader = ','
let g:mapleader = ','

"[  TRAILING WHITESPACE  ]--------------"
hi RedundantSpaces ctermfg=214 ctermbg=160 cterm=bold guifg=red gui=bold
match RedundantSpaces / \+\ze\t/
match errorMsg /[^\t]\zs\t+/

"[  GREP/AG/ACK  ]----------------------"
" Use ag instead of grep
if executable('ag')
	set grepprg=ag\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow
	set grepformat=%f:%l:%c:%m
endif

" Search the word under the cursor with K
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" bind \ (backward slash) to grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!"
nnoremap \ :Ag<SPACE>


"----------------------------------------------------------------------------//
" => TEXT FORMATTING
"----------------------------------------------------------------------------//
set wrap
set linebreak
set autoindent
set cindent
set smartindent
set shiftwidth=4
set tabstop=4
set smarttab
set noexpandtab


"----------------------------------------------------------------------------//
" => LOOK & FEEL
"----------------------------------------------------------------------------//
set background=dark
colorscheme Tomorrow-Night
if has('gui_running')
	set guioptions-=T
	set guioptions+=c
	if has('mac')
		set guifont=Meslo\ LG\ L\ DZ\ for\ Powerline\:h9
	else
		set guifont=Meslo\ LG\ L\ DZ\ for\ Powerline\ 9
	endif
else
	set t_Co=256 "why you no tell me correct colors?!?!
	if &t_Co == 8 && $TERM !~# '^linux'
		set t_Co=16
	endif
endif

set fillchars=vert:║
set listchars=tab:↹\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
set showbreak=↪⋯⋯
set number
set relativenumber
set numberwidth=4
set ruler

"tenths of a second to show matching parentheses
set matchtime=2

" Shows matching brackets when text indicator is over them
set showmatch

" Show 5 lines of context around the cursor
set scrolloff=5
set sidescrolloff=20

" The screen won't be redrawn unless actions took place
set lazyredraw

" when moving thru the lines, the cursor will try to stay in the previous columns
set nostartofline

set cursorline
set showcmd
set pumheight=10
set diffopt+=context:3


"----------------------------------------------------------------------------//
" => MAPPINGS
"----------------------------------------------------------------------------//
nnoremap <silent> <Leader><space> :nohlsearch<CR>
nmap <Leader>l :set list!<CR>
nnoremap <Space> za
inoremap <silent> <CR> <C-R>=EnterIndent()<CR>

vmap > >gv
vmap < <gv
vmap = =gv

" This rewires n and N to do the highlighing...
nnoremap <silent> n   n:call HLNext(0.2)<cr>
nnoremap <silent> N   N:call HLNext(0.2)<cr>

" Strip trailing whitespace
nnoremap <leader>nw :%s/\s\+$//e<cr>:let @/=''<CR>


"----------------------------------------------------------------------------//
" => FOLDING
"----------------------------------------------------------------------------//
set foldenable
set foldmethod=marker
set foldlevel=0
set foldcolumn=0
set foldtext=FoldText()


"----------------------------------------------------------------------------//
" => AUTOCOMMANDS
"----------------------------------------------------------------------------//
au FileType html,css,sass,javascript,php,python,ruby,sql,vim au BufWritePre <buffer> :silent! call <SID>StripTrailingWhitespace()
autocmd! BufWritePre * :call s:timestamp()

"----------------------------------------------------------------------------//
" => ABBREVIATIONS
"----------------------------------------------------------------------------//
"     Examples of the Date abbrevations    "
"------------------------------------------"
" adate : Dec 06, 2013                     "
" xdate : Fri, 06 Dec 2013 21:52:35 PM CDT "
" rdate : Fri, 06 Dec 2013 21:52:35 -0600  "
" ldate : 2013-12-06 21:52:52              "
" sdate : 2013-12-06                       "
"------------------------------------------"

" RFC822 date format"
iab <expr> rdate strftime("%a, %d %b %Y %H:%M:%S %z")
iab <expr> xdate strftime("%a %d %b %Y %I:%M:%S %p %Z")

" American date format"
iab adate <C-R>=strftime("%b %d, %Y")<cr>

" Short date format YYYY-MM-DD
iab ldate <C-R>=strftime("%Y-%m-%d %H:%M:%S")<cr>
iab sdate <C-R>=strftime("%Y-%m-%d")<cr>
"}}}

" For Common typing mistakes"{{{
iab retunr return
iab Flase False
iab sefl self
iab pritn print
iab prnt print

iab Whta What
iab whta what

iab becuase because
iab becuas because
"}}}

iab #e   #!/usr/bin/env
iab #pl  #!/usr/bin/env perl
iab #py  #!/usr/bin/env python
iab #py3 #!/usr/bin/env python3
iab #rb  #!/usr/bin/env ruby
iab #sh  #!/bin/bash

iab ssig Jose Elera
iab lsig Jose Elera (https://github.com/jelera)

iab lorem Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras sollicitudin quam eget libero pulvinar id condimentum velit sollicitudin. Proin cursus scelerisque dui ac condimentum. Nullam quis tellus leo. Morbi consectetur, lectus a blandit tincidunt, tortor augue tincidunt nisi, sit amet rhoncus tortor velit eu felis.
iab llorem Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.


"----------------------------------------------------------------------------//
" => HELPER FUNCTIONS
"----------------------------------------------------------------------------//
function! s:timestamp()
	""" Updates the timestamp in within the first 20 lines of a files """
	let pat = '\(\(Last\)\?\s*\([Cc]hanged\?\|[Mm]odified\|[Uu]pdated\?\)\s*:\s*\).*'
	let rep = '\1' . strftime("%a %d %b %Y %I:%M:%S %p %Z")
	call s:subst(1, 20, pat, rep)
endfunction

function! s:subst(start, end, pat, rep)
	""" Substitute a string """
	let lineno = a:start
	while lineno <= a:end
		let curline = getline(lineno)
		if match(curline, a:pat) != -1
			let newline = substitute( curline, a:pat, a:rep, '' )
			if( newline != curline )
				" Only substitute if we made a change
				"silent! undojoin
				keepjumps call setline(lineno, newline)
			endif
		endif
		let lineno = lineno + 1
	endwhile
endfunction

function! <SID>StripTrailingWhitespace()
	""" Strips Trailing Whitespace """
	" Preparation: save the last search, and curson position"
	let _s=@/
	let l = line(".")
	let c = col(".")
	" Do the business"
	%s/\s\+$//e
	"Clean up: restore previous search history and cursor position"
	let @/=_s
	call cursor(l, c)
endfunction

function! EnterIndent()
	""" Indents block of code within brackets """
	let EnterIndentActive = [
				\ {'left' : '[\{\[\(]','right' : '[\)\]\}]'},
				\ {'left' : '<[^>]*>', 'right' : '</[^>]*>'},
				\ {'left' : '<?\(php\)\?', 'right' : '?>'},
				\ {'left' : '<%', 'right' : '%>'},
				\ {'left' : '\[[^\]]*\]', 'right' : '\[/[^\]]*\]'},
				\ {'left' : '<!--', 'right' : '-->'},
				\ {'left' : '\(#\)\?{[^\}]*\}', 'right' : '\(#\)\?{[^\}]*\}'},
				\ ]

	let GetLine = getline('.')
	let ColNow = col('.') - 1

	let RightGetLine = substitute(
				\ strpart(GetLine, ColNow, col('$')),
				\ '^[ ]*', '', ''
				\ )

	if RightGetLine == "" | call feedkeys("\<CR>", 'n') | return '' | endif

	for value in EnterIndentActive
		if matchstr(RightGetLine, '^' . value.right) != ""
			let EnterIndentRun = 1 | break
		endif
	endfor

	if !exists('EnterIndentRun') | call feedkeys("\<CR>", 'n') | return '' | endif

	let LeftGetLine = substitute(
				\ strpart(GetLine, 0, ColNow),
				\ '[ ]*$', '', ''
				\ )

	if matchstr(LeftGetLine, value.left . '$') == ""
		call feedkeys("\<CR>", 'n') | return ''
	endif

	let LineNow = line('.')
	let Indent = substitute(LeftGetLine, '^\([ |\t]*\).*$', '\1', '')

	call setline(LineNow, LeftGetLine)
	call append(LineNow, Indent . RightGetLine)
	call append(LineNow, Indent)
	call feedkeys("\<Down>\<Esc>\A\<Tab>", 'n')

	return ''
endfunction

function! HLNext (blinktime)
	""" Used to enhance n N, it highlights the next search match """
	highlight WhiteOnRed ctermfg=white ctermbg=red
	let [bufnum, lnum, col, off] = getpos('.')
	let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
	let target_pat = '\c\%#'.@/
	let ring = matchadd('WhiteOnRed', target_pat, 101)
	redraw
	exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
	call matchdelete(ring)
	redraw
endfunction

function! FoldText(...)
	""" It sets the text for folds """

	" This function uses code from doy's vim-foldtext:
	" https://github.com/doy/vim-foldtext
	" Prepare fold variables {{{
	" Use function argument as line text if provided
	let l:line = a:0 > 0 ? a:1 : getline(v:foldstart)
	let l:line_count = v:foldend - v:foldstart + 1
	let l:indent = repeat(' ', indent(v:foldstart))
	let l:w_win = winwidth(0)
	let l:w_num = getwinvar(0, '&number') * getwinvar(0, '&numberwidth')
	let l:w_fold = getwinvar(0, '&foldcolumn')
	" }}}
	" Handle diff foldmethod {{{
	if &fdm == 'diff'
		let l:text = printf(' ⋆ %s matching lines ⋆ ', l:line_count)

		" Center-align the foldtext
		return repeat('=', (l:w_win - strchars(l:text) - l:w_num - l:w_fold) / 2) . l:text
	endif
	" }}}
	" Handle other foldmethods {{{
	let l:text = l:line
	" Remove foldmarkers {{{
	let l:foldmarkers = split(&foldmarker, ',')
	let l:text = substitute(l:text, '\V' . l:foldmarkers[0] . '\%(\d\+\)\?\s\*', '', '')
	" }}}
	" Remove comments {{{
	let l:comment = split(&commentstring, '%s')
	if l:comment[0] != ''
		let l:comment_begin = l:comment[0]
		let l:comment_end = ''
		if len(l:comment) > 1
			let l:comment_end = l:comment[1]
		endif
		let l:pattern = '\V' . l:comment_begin . '\s\*' . l:comment_end . '\s\*\$'
		if l:text =~ l:pattern
			let l:text = substitute(l:text, l:pattern, ' ', '')
		else
			let l:text = substitute(l:text, '.*\V' . l:comment_begin, ' ', '')
			if l:comment_end != ''
				let l:text = substitute(l:text, '\V' . l:comment_end, ' ', '')
			endif
		endif
	endif
	" }}}
	" Remove preceding non-word characters {{{
	let l:text = substitute(l:text, '^\W*', '', '')
	" }}}
	" Remove surrounding whitespace {{{
	let l:text = substitute(l:text, '^\s*\(.\{-}\)\s*$', '\1', '')
	" }}}
	" Make unmatched block delimiters prettier {{{
	let l:text = substitute(l:text, '([^)]*$',   '( ... )', '')
	let l:text = substitute(l:text, '{[^}]*$',   '{ ... }', '')
	let l:text = substitute(l:text, '\[[^\]]*$', '[ ... ]', '')
	" }}}
	" Add arrows when indent level > 2 spaces {{{
	if indent(v:foldstart) > 2
		let l:cline = substitute(l:line, '^\s*\(.\{-}\)\s*$', '\1', '')
		let l:clen = strlen(matchstr(l:cline, '^\W*'))
		let l:indent = repeat(' ', indent(v:foldstart) - 2)
		let l:text = '▪︎' . l:text
	endif
	" }}}
	" Prepare fold text {{{
	let l:fnum = printf(' [ Lines: %s ]           ', l:line_count)
	let l:ftext = printf('‣  %s%s ', l:indent, l:text)
	" }}}
	return l:ftext . repeat(' ', l:w_win - strchars(l:fnum) - strchars(l:ftext) - l:w_num - l:w_fold) . l:fnum . ' '
	" }}}
endfunction


"----------------------------------------------------------------------------//
" => NEOCOMPLCACHE
"----------------------------------------------------------------------------//
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Enable heavy features.
" Use camel case completion.
"let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
"let g:neocomplcache_enable_underbar_completion = 1

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplcache_enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplcache_enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_force_omni_patterns')
  let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_force_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_force_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplcache_force_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
