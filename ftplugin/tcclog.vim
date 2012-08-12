""" tcclog.vim
"""   - provides settings specific to TCC log files
"""


" Only load this ftplugin once per buffer
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1


""" }}}
""" general settings {{{
"""

" this allows for some nifty folding of TCC trace logs
setlocal foldmarker=Entering,Exiting
setlocal foldmethod=marker

""" }}}
