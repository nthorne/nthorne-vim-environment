""" .vimrc
"""   - Vim initialization settings
"""


"""
""" general setup {{{
"""

call plug#begin()
Plug 'https://github.com/scrooloose/nerdtree.git', {'on': 'NERDTreeToggle'}
Plug 'https://github.com/MarcWeber/vim-addon-mw-utils.git'
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/scrooloose/nerdcommenter'
Plug 'https://github.com/tednaleid/bufexplorer.git', {'on': 'BufExplorer'}
Plug 'https://github.com/Lokaltog/vim-easymotion.git'
Plug 'https://github.com/vim-scripts/a.vim.git', {'for': 'cpp'}
Plug 'https://github.com/nthorne/snipmate.vim'
Plug 'https://github.com/vim-scripts/DoxygenToolkit.vim.git', {'for': 'cpp'}
Plug 'https://github.com/nthorne/vim-pybreak.git', {'for': 'python'}
Plug 'https://github.com/superjudge/tasklist-pathogen.git'
Plug 'https://github.com/vim-scripts/OmniCppComplete.git'
Plug 'https://github.com/klen/python-mode.git', {'for': 'python'}
Plug 'https://github.com/plasticboy/vim-markdown.git'
Plug 'https://github.com/myusuf3/numbers.vim.git'
Plug 'https://github.com/vim-scripts/Gundo.git', {'on': 'GundoToggle'}
Plug 'https://github.com/tpope/vim-abolish.git'
Plug 'https://github.com/vim-scripts/YankRing.vim.git'
Plug 'https://github.com/majutsushi/tagbar.git', {'on': 'TagbarToggle'}
Plug 'https://github.com/Raimondi/delimitMate.git'
Plug 'https://github.com/godlygeek/tabular.git'
Plug 'https://github.com/Shougo/neocomplcache.vim.git'
Plug 'https://github.com/fatih/vim-go.git', {'for': 'go'}
Plug 'https://github.com/michaeljsmith/vim-indent-object.git'
Plug 'https://github.com/kshenoy/vim-signature.git'
Plug 'https://github.com/airblade/vim-gitgutter.git'
Plug 'https://github.com/wting/rust.vim.git', {'for': 'rust'}
Plug 'https://github.com/tpope/vim-repeat.git'
Plug 'https://github.com/vim-scripts/Improved-AnsiEsc.git'
Plug 'https://github.com/nthorne/vim-et.git'
Plug 'https://github.com/junegunn/fzf', {'dir': '~/.fzf', 'do': 'yes \| ./install'} | Plug 'https://github.com/nthorne/fzf.vim'
Plug 'https://github.com/terryma/vim-multiple-cursors.git'
Plug 'https://github.com/vimwiki/vimwiki.git'
" Vim-misc and vim-shell are requirements for vim-notes
Plug 'https://github.com/xolox/vim-misc.git'
Plug 'https://github.com/xolox/vim-shell.git'
Plug 'https://github.com/xolox/vim-notes.git'
" Under evaluation
Plug 'https://github.com/lambdatoast/elm.vim'
Plug 'https://github.com/tpope/vim-dispatch.git'
Plug 'https://github.com/derekwyatt/vim-scala.git'
Plug 'https://github.com/altercation/vim-colors-solarized.git'
Plug 'https://github.com/neomake/neomake.git'
call plug#end()


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

set wildignore+=*.o,*.pyc,*.a " ignore compiled files
set wildignore+=*.sw[op]      " ignore swap files
set wildignore+=*.pdf         " ignore binaru documents"

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
"colorscheme nthorne " .. with a stylish color scheme
set background=dark
let g:solarized_termcolors=256
colorscheme solarized

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
    au Syntax notes normal zR

    " this provides a simple template file system: for any file, if a file named
    " template.<extension> exists in the skel dir, it is read into the buffer
    au BufNewFile Makefile silent! 0r $HOME/.vim/skel/Makefile
    au BufNewFile * silent! 0r $HOME/.vim/skel/template.%:e

    " Large files are > 10M
    " Set options:
    " eventignore+=FileType (no syntax highlighting etc
    " assumes FileType always on)
    " noswapfile (save copy of file)
    " bufhidden=unload (save memory when other file is viewed)
    " buftype=nowritefile (is read-only)
    " undolevels=-1 (no undo possible)
    let g:LargeFile = 1024 * 1024 * 10
    autocmd BufReadPre * let f=expand("<afile>") | if getfsize(f) > g:LargeFile | set eventignore+=FileType | setlocal noswapfile bufhidden=unload buftype=nowrite undolevels=-1 | else | set eventignore-=FileType | endif
  augroup END
endif


""" }}}
""" keybindings {{{
"""

let mapleader = ' '
let maplocalleader = '  '

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
"nnoremap <silent> <Leader>f :call gather#Gather(input("Pattern: "))<CR>


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

" vimgrep for word under cursor
nnoremap <leader>gw :execute "vimgrep /".expand('<cword>')."/j **" <Bar> :cw<CR>

nnoremap <leader>e :botright cope<CR>
nnoremap <leader>n :cn<CR>
nnoremap <leader>p :cp<CR>

" this makes more sense, since it is far more useful to be able
" to easily jump to a bookmarked row, col rather than just row
nnoremap ' `
nnoremap ` '


map <Leader>tl <Plug>TaskList

" make tagjump a bit easier
nnoremap § :tj /

" for easy toggling of list
nnoremap <localleader>l  :set invlist<BAR>set list?<CR>

" clear search highlights
nnoremap <leader>/ :nohlsearch<CR>

" keymapping for deleting trailing whitespaces
nnoremap <localleader>d mz:%s/\s\+$//<CR>:let @/=''<CR>`z

nnoremap <localleader>D :diffoff!<CR>

" Split lines (and trim trailing whitespaces).
nnoremap S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w

nnoremap <C-A-p> :CtrlPTag<cr>

" Turn off the annoying ex mode
nnoremap Q <nop>

nnoremap <leader>a :Ag<Space>
nnoremap <leader>f :FZF<CR>

nnoremap <leader>t :Tags<CR>

" Location list keybindings
nnoremap <localleader>lo :lopen<CR>
nnoremap <localleader>lc :lclose<CR>

" Get rid of the annoying ex-mode
map q: :q

if has('nvim')
  tnoremap <localleader><Esc> <C-\><C-n>:set relativenumber<CR>
  nnoremap <localleader>s :spl<CR>:terminal<CR>
endif


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
    \ 'zsh': { 'left': '#' },
    \ 'vim': { 'left': '"'}
  \ }

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

" setup jedi-vim
" let g:jedi#popup_on_dot=0

let g:notes_directories = ['~/Documents/notes']
let g:notes_suffix='.md'
let g:notes_conceal_code=0
let g:notes_conceal_italic=0
let g:notes_conceal_bold=0
let g:notes_conceal_url=0


""" }}}

""" }}}
""" Functions {{{
"""

" function! TransformGroceryList() {{{
"   Reformat a grocery shopping list
function! TransformGroceryList()
  g/^[^ ]/d
  %s/^[ ]\+\(.*\)/\1/
  %s/\(.*\) (\([0-9]\+\))/\2 \1/
endfunction
" }}}

""" }}}
