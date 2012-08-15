""" .vimrc
"""   - Vim initialization settings
"""


"""
""" general setup {{{
"""

call pathogen#infect()


set nocompatible    " be a bit less vi-compatible, for useful features

set showmatch       " show matching bracket


" TODO: These tab settings might be a bit fishy to use straight off,
"   disregarding file type..
set shiftwidth=2    " use two spaces for each step of autoindent
set softtabstop=2   " use two spaces for a <Tab>
set expandtab       " use spaces rather than tabs
set backspace=2     " allow <BS> over autoindent, line breaks and insert start


set wildchar=<Tab>  " use <Tab> for command-line wildcard expansion

set incsearch       " use incremental searches

set hlsearch        " highlight last search

set splitright      " vsplit windows to the right of current

set nosplitbelow    " hsplit windows above current

if has('mouse')
  set mouse=a       " enable mouse support, if available
endif

set updatecount=20  " reduce updatecount, for more frequent swap file writes


filetype plugin on  " turn on filetype plugin loading
filetype indent on  " turn on filetype indent loading

""" }}} 
""" appearance {{{
"""

set shortmess+=I    " skip the vim intro message


if &term =~ "xterm"         " if terminal is xterm..
  if has("terminfo")        " .. and terminfo database is used
	set t_Co=8          "   .. set color count to 8
	set t_Sf=[3%p1%dm "   .. foreground color
	set t_Sb=[4%p1%dm "   .. background color
  else
	set t_Co=8          "   .. set color count to 8
	set t_Sf=[3%dm    "   .. foreground color
	set t_Sb=[4%dm    "   .. background color
  endif
endif

syntax on           " turn on syntax highlighting..
colorscheme nthorne " .. with a stylish color scheme

set number          " turn on line numbering

" set the statusline
set statusline=%<                           " truncate line at start
set statusline+=%f                          " file type
set statusline+=%h                          " help buffer flag
set statusline+=%m                          " modified flag
set statusline+=%r                          " readonly flag
set statusline+=\ %y                        " filetype
set statusline+=\ [%{&ff}]                  " fileformat
set statusline+=\ %{fugitive#statusline()}  " git branch
set statusline+=\ [%L\ lines]               " line count
set statusline+=%=                          " right align
set statusline+=%l,%c                       " line, column of cursor
set statusline+=%V                          " virtual column

set laststatus=2    " always show the status line

set showmode        " show the current mode on the last line
set ruler           " show cursor position (overridden by statusline)

set diffopt=filler,iwhite " show filler lines, and ignore whitespace changes


""" }}}
""" autocommands {{{
"""

if has('autocmd')
  augroup nthorne_augroup
    au!

    " When editing a file, always jump to the last known cursor
    " position. Don't do it when the position is invalid or when inside
    " an event handler (happens when dropping a file on gvim).
    " 
    " (from Bill Odom's vim environment)
    au BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \ exe "normal g`\"" |
      \ endif

    au Filetype cpp setlocal foldmethod=syntax

    " make sure all files are unfolded by default
    au BufRead,BufNewFile * normal zR

    " this provides a simple template file system: for any file, if a file named
    " template.<extension> exists in the skel dir, it is read into the buffer
    au BufNewFile Makefile silent! 0r $HOME/.vim/skel/Makefile
    au BufNewFile * silent! 0r $HOME/.vim/skel/template.%:e

    " mark characters beyond the 80th (lines longer than 80 chars is a no-no)
    au BufWinEnter * match ErrorMsg '\%>80v.\+'

    " for python files, set the makeprg to pylint, so that we can utilize
    " a compiler plugin with an errorformat
    au FileType python setlocal makeprg=pylint\ --reports=n\ --output-format=parseable\ %:p

    " for python, map the usual compile/lint/whatnot function keys for a
    " coherent workflow
    au FileType python nnoremap <buffer> <silent> <localleader><F3> :!/usr/bin/env python %<CR>
    au FileType python nnoremap <buffer> <silent> <localleader><F5> :make<CR>

    " us the marker foldmethod for vimscript
    au FileType vim setlocal foldmethod=marker
  augroup END
endif


""" }}}
""" keybindings {{{
"""

let mapleader = '\'
let maplocalleader = '\\'

" <F1> toggles NERDTree
nnoremap <silent> <F1> :NERDTreeToggle<CR>

" <F2> toggles taglist
nnoremap <silent> <F2> :TlistToggle<CR>

" <F3> shows the Gstatus window
nnoremap <silent> <F3> :Gstatus<CR>

" <F4> shows the Buffer Explorer window
nnoremap <silent> <F4> :BufExplorer<CR>

" <F5> shows the Hiswin window
nnoremap <silent> <F5> :Histwin<CR>

" <F6> and <F7> is for navigating between files
nnoremap <silent> <F6> :prev<CR>
nnoremap <silent> <F7> :next<CR>

" <F8> is for easy window splitting
nnoremap <silent> <F8> :split<CR>

" <F11> and <F12> is for jumping back and forth through the error list
nnoremap <silent> <F11> :cp<CR>
nnoremap <silent> <F12> :cn<CR>

" Navigate the help with the ä key, rather than the slightly awkward default
nnoremap ä <C-]>

" on <Leader>f Search for pattern, and gather the result in a new scratch buffer
nnoremap <silent> <Leader>f :call gather#Gather(input("Pattern: "))<CR>


" Toggle wrapping the display of long lines (and display the current 'wrap'
" state once it's been toggled).
" (from Bill Odom's vim environment)
nnoremap <leader>w  :set invwrap<BAR>set wrap?<CR>

" Handy shortcut for editing my .vimrc
nnoremap <leader>ev :split $MYVIMRC<CR>

" Handy shortcut for sourcing my .vimrc
nnoremap <leader>sv :source $MYVIMRC<CR>

" lcd to path of current file
nnoremap <leader>lcf :lcd %:p:h<CR>


""" }}}
""" host specific options {{{
"""

" if at one of the work servers, expand the path for usefule file motions
if common#IsWorkHost()
  source $HOME/.vim/work_profile.vim
endif


""" }}}
""" plugin settings {{{
"""

" setup taglist
let g:Tlist_Use_Right_Window=1

" setup NERDCommenter
let g:NERDCustomDelimiters = {
    \ 'zsh': { 'left': '#' }
  \ }  

""" }}}
