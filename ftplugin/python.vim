""" python.vim
"""   - provides python specific settings
"""


" Only load this ftplugin once per buffer
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1


""" }}}
""" general settings {{{
"""

" override the 'default' setting with 2 spaces here, for PEP-8 compliance
setlocal tabstop=4        " use four spaces for each <Tab> in the file
setlocal shiftwidth=4     " use four spaces for each step of autoindent
setlocal softtabstop=4    " use four spaces for a <Tab>
setlocal expandtab        " use spaces rather than tabs
setlocal smarttab
setlocal backspace=2      " allow <BS> over autoindent, line breaks and insert start

setlocal textwidth=80

setlocal nosmartindent    " turn off this one to get python indentation running
""" }}}
