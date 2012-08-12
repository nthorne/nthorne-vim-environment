""" pylint.vim
"""   - provides settings for the pylint 'compiler'
"""


" allow overruling or adding to this file
if exists("current_compiler")
  finish
endif
let current_compiler = "pylint"

" if CompilerSet does not exist, define it as :setlocal
if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif


setlocal errorformat=%A%f:%l:\ [%t%.%#]\ %m,%Z%p^^,%-C%.%#
