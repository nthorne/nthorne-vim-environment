"""
""" general setup
"""

" initialise pathogen
call pathogen#infect()

" be a bit less vi-compatible, in order to provide some useful features
set nocompatible

" use the 'magic' setting to keep patterns portable
set sm

" use 2 spaces for TAB as default
" TODO: this one is perhaps a bit fishy
set sw=2
set sts=2
set expandtab
set bs=2

" use tab to do wild card expansion in the command line 
set wildchar=<Tab>

" turn on incremental searches
set incsearch

" turn on highlighting of last search
set hlsearch

" when vsplitting, put the new window to the right of current
set splitright

" when hsplitting, put the new window above current
set nosplitbelow

" enable mouse support, if available
if has('mouse')
  set mouse=a
endif

" reduce the updatecount a bit, so that the swap file is written to a bit more
" often
set updatecount=20


"""
""" appearance
"""

set shortmess+=I
" color settings
" TODO: what does this one do? (and where did i get it from?)
if &term =~ "xterm"
  if has("terminfo")
	set t_Co=8
	set t_Sf=[3%p1%dm
	set t_Sb=[4%p1%dm
  else
	set t_Co=8
	set t_Sf=[3%dm
	set t_Sb=[4%dm
  endif
endif

" turn on syntax highlighting (with a stylish color scheme)
syntax on
colorscheme nthorne

" turn on line numbers
set number

" set the statusline (including filetype, amongst other)
set statusline=%<%f%h%m%r\ [%{&ff}]\ %{fugitive#statusline()}\ %l,%c%V
set laststatus=2

" setup the ruler
set showmode
set ruler

" ignore whitespace changes, and show filler lines
set diffopt=filler,iwhite


"""
""" autocommands
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

    " make vim recognise cpp file types, and set the appropriate folding method
    au BufRead,BufNewFile *.hpp set filetype=cpp
    au BufRead,BufNewFile *.cc set filetype=cpp
    au Filetype cpp set foldmethod=syntax

    " make sure all files are unfolded by default
    au BufRead,BufNewFile * normal zR

    " this provides a simple template file system - for any file, if a file named
    " template.<extension> exists in the skel dir, it is read into the new buffer
    au BufNewFile Makefile silent! 0r $HOME/.vim/skel/Makefile
    au BufNewFile * silent! 0r $HOME/.vim/skel/template.%:e

    " mark characters beyond the 80th (since lines longer than 80 chars is a no-no)
    au BufWinEnter * match ErrorMsg '\%>80v.\+'

    " for python files, set the makeprg to pylint, so that we can utilize
    " a compiler plugin with an errorformat
    au FileType python set makeprg=pylint\ --reports=n\ --output-format=parseable\ %:p

    " for python, map the usual compile/lint/whatnot function keys for a
    " coherent workflow
    au FileType python nnoremap <silent> <localleader><F3> :!/usr/bin/env python %<CR>
    au FileType python nnoremap <silent> <localleader><F5> :make<CR>
  augroup END

  filetype plugin on
endif


"""
""" keybindings
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
runtime functions/gather.vim
nnoremap <silent> <Leader>f :call Gather(input("Pattern: "))<CR>


" Toggle wrapping the display of long lines (and display the current 'wrap'
" state once it's been toggled).
" (from Bill Odom's vim environment)
nnoremap <leader>w  :set invwrap<BAR>set wrap?<CR>

" Handy shortcut for editing my .vimrc
nnoremap <leader>ev :split $MYVIMRC<CR>

" Handy shortcut for sourcing my .vimrc
nnoremap <leader>sv :source $MYVIMRC<CR>

" lcd to path of current file
nnoremap <localleader>lcf :lcd %:p:h<CR>


"""
""" host specific options
"""

" if at one of the work servers, expand the path for usefule file motions
if hostname() =~ 'gbguxs\d\+'
  source $HOME/.vim/work_profile.vim
endif


"""
""" plugin settings 
"""

" setup compiler options for the c-support plugin
let g:C_CplusCompiler="CC"
let g:C_CFlags="-g"
let g:C_LFlags="-g"
let g:C_Comments='no'


" setup taglist
let g:Tlist_Use_Right_Window=1
