""" sh.vim
"""   - provides settings specific for sh script files
"""


" Only load this ftplugin once per buffer
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1


""" }}}
""" general settings {{{
"""

setlocal foldmethod=marker
setlocal autoindent

" mark lines longer than 80 characters
match ErrorMsg '\%>80v.\+'

""" }}}
""" keybindings {{{
"""

nnoremap <buffer> <silent> <localleader><F3> :!./%<CR>

""" }}}
