""" markdown.vim
"""   - provides settings specific markdown files
"""


" Only load this ftplugin once per buffer
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1


""" }}}
""" general settings {{{
"""

" turn on spell checking for markdown
setlocal spell

""" }}}
