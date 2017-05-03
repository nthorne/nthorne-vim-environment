""" rust.vim
"""   - provides rust specific settings
"""

setlocal makeprg=cargo


" Only load this ftplugin once per buffer
if exists("b:did_ftplugin_nthorne")
  finish
endif
let b:did_ftplugin_nthorne = 1


""" }}}
""" general settings {{{
"""

setlocal foldmethod=syntax

set shiftwidth=4    " use four spaces for each step of autoindent
set softtabstop=4   " use four spaces for a <Tab>

" mark lines longer than 80 characters
match ErrorMsg '\%>80v.\+'

" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview

" Set up racer
set hidden
let g:racer_cmd="racer"
let g:racer_experimental_completer=1

" Setup a rustc neomake maker
let g:neomake_rust_rustc_maker = {
      \ 'exe': 'rustc',
      \ 'args': ['-o /dev/null'],
      \ 'cwd': '%:p:h'
      \}
let g:neomake_rust_enabled_makers = ['rustc']

" Setup rust-doc
let g:rust_doc#downloaded_rust_doc_dir = '~/Documents/rust-docs'

""" }}}

""" }}}
""" autocommands {{{
"""
if has('autocmd')
  augroup nthorne_ftplugin_rust_augroup
    au!
    au BufWrite * call common#CleanupCppBeforeWrite()
    au BufWritePost * Neomake
  augroup END
endif


""" }}}
""" keybindings {{{
"""
nnoremap <buffer> <silent> <localleader><F1> :compiler rustc<CR> :make<CR>
nnoremap <buffer> <silent> <localleader><F3> :compiler cargo<CR> :make build<CR>
nnoremap <buffer> <silent> <localleader><F4> :compiler cargo<CR> :make test<CR>
nnoremap <buffer> <silent> <localleader><F7> :compiler cargo<CR> :make run<CR>

" This is a bit naive, but use RLS if the binary exists, and
" fall back to racer if not.
if executable("rls")
  nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
  nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
  nnoremap <silent> <F2>  :call LanguageClient_textDocument_rename()<CR>
else
  nmap <silent> gd <Plug>(rust-def)
  nmap <silent> gs <Plug>(rust-def-split)
  nmap <silent> gx <Plug>(rust-def-vertical)
endif

nmap <leader>gd <Plug>(rust-doc)

""" }}}
