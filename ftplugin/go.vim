""" go.vim
"""   - provides go specific settings
"""


" Only load this ftplugin once per buffer
if exists("b:did_own_ftplugin")
  finish
endif
let b:did_own_ftplugin = 1

""" }}}
""" keybindings {{{
"""
" <localleader><F3> executes GoBuild
nnoremap <buffer> <silent> <localleader><F3> :GoBuild<CR>
" <localleader><F4> executes GoTest
nnoremap <buffer> <silent> <localleader><F4> :GoTest<CR>
" <localleader><F5> executes GoLint
nnoremap <buffer> <silent> <localleader><F5> :GoLint<CR>
" <localleader><F7> executes GoRun
nnoremap <buffer> <silent> <localleader><F7> :GoRun<CR>

nnoremap <buffer> <silent> <localleader>ud :!ctags -R --exclude='.git' --c-kinds=+p --fields=+iaS --extra=+q . <CR>

""" }}}
""" general settings {{{
"""

setlocal foldmethod=syntax

" mark lines longer than 80 characters
match ErrorMsg '\%>80v.\+'

""" }}}
