""" cpp.vim
"""   - provides cpp specific settings
"""


" Only load this ftplugin once per buffer
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1


""" }}}
""" general settings {{{
"""

if common#IsWorkHost()
  call work#ConstructPath()
endif

setlocal foldmethod=syntax


""" }}}
