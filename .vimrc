""" .vimrc
"""   - Vim initialization settings
"""


"""
""" general setup {{{
"""

call plug#begin()
Plug 'https://github.com/vim-scripts/OmniCppComplete.git', {'for': 'cpp'}
Plug 'https://github.com/LnL7/vim-nix', {'for': 'nix'}
Plug 'https://github.com/Lokaltog/vim-easymotion.git'
Plug 'https://github.com/MarcWeber/vim-addon-mw-utils.git'
Plug 'https://github.com/Raimondi/delimitMate.git'
Plug 'https://github.com/airblade/vim-gitgutter.git'
"Plug 'https://github.com/altercation/vim-colors-solarized.git'
Plug 'https://github.com/godlygeek/tabular.git'
Plug 'https://github.com/gregsexton/gitv'
Plug 'https://github.com/junegunn/fzf', {'dir': '~/.fzf', 'do': 'yes \| ./install'} | Plug 'https://github.com/junegunn/fzf.vim'
Plug 'https://github.com/kshenoy/vim-signature.git'
Plug 'https://github.com/majutsushi/tagbar.git', {'on': 'TagbarToggle'}
Plug 'https://github.com/michaeljsmith/vim-indent-object.git'
Plug 'https://github.com/myusuf3/numbers.vim.git'
Plug 'https://github.com/neomake/neomake.git'
Plug 'https://github.com/nthorne/snipmate.vim'
Plug 'https://github.com/nthorne/vim-et.git'
Plug 'https://github.com/nthorne/vim-pybreak.git', {'for': 'python'}
Plug 'https://github.com/plasticboy/vim-markdown.git'
Plug 'https://github.com/racer-rust/vim-racer', {'for': 'rust'}
Plug 'https://github.com/rhysd/rust-doc.vim', {'for': 'rust'}
Plug 'https://github.com/rust-lang/rust.vim', {'for': 'rust'}
Plug 'https://github.com/scrooloose/nerdcommenter'
Plug 'https://github.com/scrooloose/nerdtree.git', {'on': 'NERDTreeToggle'}
Plug 'https://github.com/superjudge/tasklist-pathogen.git'
Plug 'https://github.com/tednaleid/bufexplorer.git', {'on': 'BufExplorer'}
Plug 'https://github.com/terryma/vim-multiple-cursors.git'
Plug 'https://github.com/tpope/vim-abolish.git'
Plug 'https://github.com/tpope/vim-dispatch.git'
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'https://github.com/tpope/vim-repeat.git'
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/vim-scripts/Improved-AnsiEsc.git'
Plug 'https://github.com/vim-scripts/YankRing.vim.git'
Plug 'https://github.com/vim-scripts/a.vim.git', {'for': 'cpp'}
Plug 'https://github.com/farmergreg/vim-lastplace'
Plug 'https://github.com/wellle/visual-split.vim'
Plug 'https://github.com/justinmk/vim-sneak'
" <vim-radical>
Plug 'https://github.com/glts/vim-magnum'
Plug 'https://github.com/glts/vim-radical'
" </vim-radical>
Plug 'https://github.com/mtth/scratch.vim'

" Under evaluation
"Plug 'shaunsingh/solarized.nvim'
Plug 'ellisonleao/gruvbox.nvim'
" config is in ~/.config/nvim/obsidian-nvim.lua
"Plug 'https://github.com/epwalsh/obsidian.nvim'
" Required by obsidian.nvim
"lug 'nvim-lua/plenary.nvim'

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }
Plug 'github/copilot.vim', {'branch': 'release'}
Plug 'https://github.com/hashivim/vim-terraform'
Plug 'https://github.com/martinda/Jenkinsfile-vim-syntax'
Plug 'https://github.com/chrisbra/unicode.vim'
Plug 'https://github.com/dhruvasagar/vim-table-mode'
Plug 'https://github.com/Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'https://github.com/autozimu/LanguageClient-neovim', {
  \ 'branch': 'next',
  \ 'do': 'bash install.sh'
  \}

Plug 'https://github.com/waiting-for-dev/vim-www'
let g:www_engines = {'cpp': 'http://www.cplusplus.com/search.do?q='}
let g:www_default_search_engine = 'cpp'

Plug 'https://github.com/eagletmt/ghcmod-vim', {'for': 'haskell'}
Plug 'https://github.com/Shougo/vimproc', {'for': 'haskell', 'do': 'make'}

Plug 'https://github.com/aklt/plantuml-syntax.git', {'for': 'markdown,plantuml'}

Plug 'https://github.com/MattesGroeger/vim-bookmarks'

let g:rainbow_active = 1
Plug 'http://github.com/frazrepo/vim-rainbow'

let g:LanguageClient_serverCommands = {}
if executable("cquery")
  let g:LanguageClient_serverCommands.cpp = ['cquery', '--log-file=/tmp/cquery.log']
  let g:LanguageClient_serverCommands.c   = ['cquery', '--log-file=/tmp/cquery.log']
elseif executable("ccls")
  let g:LanguageClient_serverCommands.cpp = [
        \ 'ccls',
        \ '--log-file=/tmp/ccls.log',
        \ '--init={"cache":{"directory":"/tmp/.ccls-cache"}}'
        \ ]
  let g:LanguageClient_serverCommands.c = [
        \ 'ccls',
        \ '--log-file=/tmp/ccls.log',
        \ '--init={"cache":{"directory":"/tmp/.ccls-cache"}}'
        \]
endif


let g:LanguageClient_loadSettings = 1
let g:LanguageClient_settingsPath = "/home/nthorne/.vim/settings.json"

" Temporarily disabled, since it broke in an update. Also disabled
" ~./.config/nvim/plugins.lua
" Plug 'https://github.com/Vigemus/iron.nvim'

Plug 'https://github.com/mbbill/undotree'

Plug 'https://github.com/hari-rangarajan/CCTree', {'for': 'c'}

Plug 'https://github.com/tracyone/neomake-multiprocess'

Plug 'https://github.com/terryma/vim-expand-region'

" Deleted, but not really (aka might be good to have some time)..
" Plug 'https://github.com/sk1418/HowMuch'
" Plug 'https://github.com/Shougo/neocomplcache.vim.git'
" Plug 'https://github.com/udalov/kotlin-vim'
" Plug 'https://github.com/derekwyatt/vim-scala.git', {'for': 'scala'}
" Plug 'https://github.com/fatih/vim-go.git', {'for': 'go'}
" Plug 'https://github.com/lambdatoast/elm.vim', {'for': 'elm'}
" Plug 'https://github.com/vim-scripts/Gundo.git', {'on': 'GundoToggle'}
" Plug 'https://github.com/vimwiki/vimwiki.git'
" <vim-notes>
" Plug 'https://github.com/xolox/vim-misc.git'
" Plug 'https://github.com/xolox/vim-shell.git'
" Plug 'https://github.com/xolox/vim-notes.git'
" </vim-notes>
" Plug 'https://github.com/apalmer1377/factorus.git', {'for': ['c', 'cpp']}
" Plug 'https://github.com/idris-hackers/idris-vim'

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
"let g:solarized_disable_background = v:true
"let g:solarized_contrast = v:true
"let g:solarized_borders = v:true
set background=dark
let g:solarized_termcolors=256
colorscheme gruvbox


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

let g:netrw_liststyle=1

""" }}}
""" autocommands {{{
"""

if has('autocmd')
  augroup nthorne_augroup
    au!

    " make sure all files are unfolded by default
    au BufRead,BufNewFile * normal zR
    au Syntax notes normal zR

    " this provides a simple template file system: for any file, if a file named
    " template.<extension> exists in the skel dir, it is read into the buffer
    au BufNewFile Makefile silent! 0r $HOME/.vim/skel/Makefile
    au BufNewFile CMakeLists.txt silent! 0r $HOME/.vim/skel/CMakeLists.txt
    au BufNewFile .envrc silent! 0r $HOME/.vim/skel/.envrc
    au BufNewFile shell.nix silent! 0r $HOME/.vim/skel/shell.nix
    au BufNewFile flake.nix silent! 0r $HOME/.vim/skel/flake.nix
    au BufNewFile default.nix silent! 0r $HOME/.vim/skel/default.nix
    au BufNewFile Dockerfile silent! 0r $HOME/.vim/skel/Dockerfile
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

let mapleader = ','
let maplocalleader = ',,'
map <space> <leader>
map <space><space> <leader><leader>

" <F1> toggles NERDTree
nnoremap <silent> <F1> :NERDTreeToggle<CR>

" <F2> toggles tagbar
" note: for some reason, I need to reenable line numbering here..
nnoremap <silent> <F2> :TagbarToggle<CR>:set number<CR>:NumbersEnable<CR>

" <F3> shows the Gstatus window
nnoremap <silent> <F3> :Git<CR>:set nofoldenable<CR>

" <F4> shows the Buffer Explorer window
nnoremap <silent> <F4> :BufExplorer<CR>

" <F5> shows the Hiswin window
nnoremap <silent> <F5> :UndotreeToggle<CR>

" <F6> and <F7> is for navigating between files
nnoremap <silent> <F6> :prev<CR>
nnoremap <silent> <F7> :next<CR>

" <F8> is for easy window splitting
" nnoremap <silent> <F8> :split<CR>

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
nnoremap <leader>b :Buffers<CR>

nnoremap <leader>t :Tags<CR>

" Location list keybindings
nnoremap <localleader>lo :lopen<CR>
nnoremap <localleader>lc :lclose<CR>

" Get rid of the annoying ex-mode
map q: :q

if has('nvim')
  tnoremap <localleader><Esc> <C-\><C-n>:set relativenumber<CR>
  "nnoremap <localleader>s :spl<CR>:terminal<CR>
endif


""" }}}
""" host specific options {{{
"""

" if at one of the work servers, expand the path for usefule file motions
if common#IsWorkHost()
  source $HOME/.vim/work_profile.vim
elseif common#IsWorkVM()
  source $HOME/.vim/work_vm_profile.vim
elseif hostname() =~ "vimes"
  source $HOME/.vim/vimes_profile.vim
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

" Setup NERDTree
let NERDTreeShowLineNumbers=1
autocmd FileType nerdtree setlocal relativenumber


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

let g:notes_directories = ['~/Documents/notes']
let g:notes_suffix='.md'
let g:notes_conceal_code=0
let g:notes_conceal_italic=0
let g:notes_conceal_bold=0
let g:notes_conceal_url=0

" setup fzf tags
let g:fzf_tags_command = 'ctags -R --exclude=".git" --exclude=".direnv"'

" Show vim-sneak labels..
let g:sneak#label=1

" Enable deoplete at startup
let g:deoplete#enable_at_startup = 1

" Set up LanguageClient
" Required for operations modifying multiple buffers like rename.
set hidden
if executable("rls")
  let g:LanguageClient_serverCommands.rust = ['rls']
endif
" Automatically start language servers.
let g:LanguageClient_autoStart = 1
let g:LanguageClient_useVirtualText = "All"

" Setup vim-bookmark
let g:bookmark_no_default_key_mappings = 1
nnoremap <Leader>mm :BookmarkToggle<CR>
nnoremap <Leader>mi :BookmarkAnnotate<CR>
nnoremap <Leader>ma :BookmarkShowAll<CR>
nnoremap <Leader>mj :BookmarkNext<CR>
nnoremap <Leader>mk :BookmarkPrev<CR>
nnoremap <Leader>mc :BookmarkClear<CR>
nnoremap <Leader>mx :BookmarkClearAll<CR>
nnoremap <Leader>mkk :BookmarkMoveUp<CR>
nnoremap <Leader>mjj :BookmarkMoveDown<CR>
nnoremap <Leader>mg :BookmarkMoveToLine<CR>
let g:bookmark_annotation_sign="✎"

" Set up LanguageClient
nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent>gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent>gD :call LanguageClient_textDocument_definition({'gotoCmd': 'split'})<CR>
nnoremap <localleader>lr :call LanguageClient_textDocument_rename()<CR>
nnoremap <localleader>ld :call LanguageClient_textDocument_documentSymbol()<CR>
nnoremap <localleader>lf :call LanguageClient_textDocument_references()<CR>
nnoremap <localleader>ls :call LanguageClient_workspace_symbol()<CR>

nnoremap <silent> - :lcd ..<CR>:pwd<CR>

" Turn off snippet support, since snipmate, deoplete and LanguageClient does
" not play nice (snippet placeholders inserted as text; really annoying).
let g:LanguageClient_hasSnippetSupport=0

" iron settings
"let g:iron_map_defaults=0
" <F8> is for toggling iron
let g:iron_map_defaults=0
let g:iron_map_extended=0
nnoremap <silent> <F8> :IronRepl<CR>
" Map Esc to the return to normal mode key combo (there's no point in breaking
" fingers here; we're using vim, not emacs).
tnoremap <Esc> <C-\><C-n>
nmap <localleader>is <Plug>(iron-send-motion)
nmap <localleader>ir <Plug>(iron-repeat-cmd)
nmap <localleader>if :execute 'IronSend! .L '.expand('%')<CR>

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
  %sort
endfunction
" }}}

""" }}}
