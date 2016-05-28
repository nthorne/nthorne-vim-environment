""" scala.vim
"""   - provides scala specific settings
"""


" Only load this ftplugin once per buffer
if exists("b:did_own_ftplugin")
  finish
endif
let b:did_own_ftplugin = 1

""" }}}
""" autocommands {{{
"""
if has('autocmd')
  augroup nthorne_ftplugin_scala_augroup
    au!

    au BufWritePost * Neomake
  augroup END
endif


""" }}}
