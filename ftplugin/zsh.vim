""" zsh.vim
"""   - provides settings specific for zsh script files
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
