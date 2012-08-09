" Vim compiler file
" Compiler:         pylint
" Maintainer:       Niklas Thorne
" Latest Revision:  2012-08-09

if exists("current_compiler")
  finish
endif
let current_compiler = "pylint"


setlocal errorformat=%A%f:%l:\ [%t%.%#]\ %m,%Z%p^^,%-C%.%#
