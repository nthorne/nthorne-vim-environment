" Vim compiler file
" Compiler:	Google Mox
" Maintainer:	Niklas Thorne <notrupertthorne@gmail.com>
" Last Change: 2012 Sep 26

if exists("current_compiler")
  finish
endif
let current_compiler = "pymox"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

" This errorformat is basically the same as that for pyunit, with the
" exception that a pattern for ignoring error reported from the mox framework
" has been prepended to the pyunit errorformat.
CompilerSet efm=\
      \%-G\ \ File%.%#mox.py%.%#,\
      \%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,\
      \%C\ \ \ \%.%#,\
      \%Z%[%^\ ]%\\@=%m

