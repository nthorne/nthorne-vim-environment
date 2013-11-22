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

set wildmenu        " show the command-line completion menu

set wildignore=*.o,*.pyc,*.sw[op] " ignore compiled files, and swap files

set hidden          " hide buffers rather than abandoning them when unloaded

set noerrorbells    " turn off audible bell..
set novisualbell    " .. as well as the visual bell

set ignorecase      " ignore casing of normal letters..
set smartcase       " .. but consider casing if pattern contains uppercase chars

set listchars+=trail:_  " show trailing
set listchars+=tab:>-   " show tabs

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

    " make sure all files are unfolded by default
    au BufRead,BufNewFile * normal zR

    " this provides a simple template file system: for any file, if a file named
    " template.<extension> exists in the skel dir, it is read into the buffer
    au BufNewFile Makefile silent! 0r $HOME/.vim/skel/Makefile
    au BufNewFile * silent! 0r $HOME/.vim/skel/template.%:e

  augroup END
endif


""" }}}
""" keybindings {{{
"""

let mapleader = ','
let maplocalleader = ',,'

" <F1> toggles NERDTree
nnoremap <silent> <F1> :NERDTreeToggle<CR>

" <F2> toggles tagbar
" note: for some reason, I need to reenable line numbering here..
nnoremap <silent> <F2> :TagbarToggle<CR>:set number<CR>:NumbersEnable<CR>

" <F3> shows the Gstatus window
nnoremap <silent> <F3> :Gstatus<CR>:set nofoldenable<CR>

" <F4> shows the Buffer Explorer window
nnoremap <silent> <F4> :BufExplorer<CR>

" <F5> shows the Hiswin window
nnoremap <silent> <F5> :GundoToggle<CR>

" <F6> and <F7> is for navigating between files
nnoremap <silent> <F6> :prev<CR>
nnoremap <silent> <F7> :next<CR>

" <F8> is for easy window splitting
nnoremap <silent> <F8> :split<CR>

" <F9> is for showing the yankring
nnoremap <silent> <F9> :YRShow<CR>

" Navigate the help with the ä key, rather than the slightly awkward default
nnoremap ä <C-]>

" Allow for a more american-esque colon
nnoremap ö :

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

" cd to path of current buffer
nnoremap <leader>cd :cd %:p:h<CR>

" lcd to path of current buffer
nnoremap <leader>lcd :lcd %:p:h<CR>

" shortcut for saving
nnoremap <leader>s :w!<CR>

" shortcut for saving a session
nnoremap <leader>ss :mksession! ~/Session.vim<CR>

" shortcut for restoring a session
nnoremap <leader>rs :so ~/Session.vim<CR>

" Toggle the Numbers plugin
nnoremap <leader>nt :NumbersToggle<CR>


" nifty window navigation keymappings
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

nnoremap <leader>o :only<CR>

" tab management mappings
nnoremap <leader>tn :tabnew<CR>
nnoremap <leader>to :tabonly<CR>
nnoremap <leader>tc :tabclose<CR>
nnoremap <leader>tm :tabmove<CR>

nnoremap <leader>te :tabedit <C-r>=expand("%:p:h")<CR>/

" move a line of text down/up with ALT+j/k
nnoremap <M-j> mz:m+<CR>`z
nnoremap <M-k> mz:m-2<CR>`z

" move selected lines down/up in visual mode with ALT+j/k
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" vimgrep all files recursively
nnoremap <leader>g :vimgrep // **/*<left><left><left><left><left><left>

" vimgrep current file
nnoremap <leader><space> :vimgrep // %<left><left><left>

nnoremap <leader>e :botright cope<CR>
nnoremap <leader>n :cn<CR>
nnoremap <leader>p :cp<CR>

" this makes more sense, since it is far more useful to be able
" to easily jump to a bookmarked row, col rather than just row
nnoremap ' `
nnoremap ` '


nnoremap <leader>tl :TaskList<CR>

" make tagjump a bit easier
nnoremap § :tj /

" for easy toggling of list
nnoremap <localleader>l  :set invlist<BAR>set list?<CR>

" clear search highlights
nnoremap <leader>chl :let @/=''<CR>

" keymapping for deleting trailing whitespaces
nnoremap <localleader>d mz:%s/\s\+$//<CR>:let @/=''<CR>`z

nnoremap <localleader>D :diffoff!<CR>

" Split lines (and trim trailing whitespaces).
nnoremap S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w

""" }}}
""" host specific options {{{
"""

" if at one of the work servers, expand the path for usefule file motions
if common#IsWorkHost()
  source $HOME/.vim/work_profile.vim
elseif common#IsWorkVM()
  source $HOME/.vim/work_vm_profile.vim
endif


""" }}}
""" external modules {{{
"""
runtime macros/matchit.vim



""" }}}
""" plugin settings {{{
"""

" setup NERDCommenter
let g:NERDCustomDelimiters = {
    \ 'zsh': { 'left': '#' }
  \ }

" setup ctrlp
let g:ctrlp_regexp=1        " use regexes for ctrlp matching

" setup tasklist
let g:tlTokenList=['666', 'TODO', 'FIXME', 'XXX']

" setup yankring
let g:yankring_replace_n_pkey=''
let g:yankring_replace_n_nkey=''

" setup tagbar
let g:tagbar_autoclose=1

" setup delimitMate
let g:delimitMate_expand_cr=1

" setup neocomplcache
let g:neocomplcache_enable_at_startup=1
let g:neocomplcache_enable_smart_case=1
let g:neocomplcache_enable_camel_case_completion=1
inoremap <expr><C-l> neocomplcache#complete_common_string()

""" }}}
