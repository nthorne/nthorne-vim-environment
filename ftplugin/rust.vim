""" rust.vim
"""   - provides rust specific settings
"""

setlocal makeprg=cargo


" Only load this ftplugin once per buffer
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1


""" }}}
""" general settings {{{
"""

setlocal foldmethod=syntax

" mark lines longer than 80 characters
match ErrorMsg '\%>80v.\+'

" OmniCppComplete settings
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std"]
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview

""" }}}

""" }}}
""" autocommands {{{
"""
if has('autocmd')
  augroup nthorne_ftplugin_rust_augroup
    au!
    au BufWrite * call common#CleanupCppBeforeWrite()

  augroup END
endif

""" }}}


""" }}}
""" keybindings {{{
"""
nnoremap <buffer> <silent> <localleader><F3> :make build<CR>
nnoremap <buffer> <silent> <localleader><F7> :make run<CR>
