""" work_profile.vim
"""   - contains work-vm specific settings
"""


""" }}}
""" general settings {{{
"""

" Apparently, NERDTree does not render menu properly at work, so we'll go
"  old-style
let NERDTreeDirArrows=0

let g:ctrlp_working_path_mode='rw'

" Neomake checkers
let g:neomake_cpp_qacpp_maker = {
      \ 'exe': 'qacpp',
      \ 'errorformat': '%f(%l\,%c): %m',
      \ 'cwd': '%:p:h'
      \}
let g:neomake_cpp_lbuild_maker = {
      \ 'exe': 'lbuild',
      \ 'cwd': '%:p:h',
      \ 'errorformat':
            \ '"%f"\, line %l: %trror: %m,'.
            \ '"%f"\, line %l: %tarning: %m'
      \}

let g:neomake_cpp_doxy_maker = {
      \ 'exe': 'doxy',
      \ 'cwd': '%:p:h',
      \ 'errorformat':
            \ '%f:%l: %trror: %m,'.
            \ '%f:%l: %tarning: %m'
      \}
let g:neomake_cpp_enabled_makers = ['lbuild','qacpp','doxy']

""" }}}
""" autocommands {{{
"""

if has('autocmd')
  augroup nthorne_work_vm_augroup
    au!

    " use the sun_cc compiler
    au FileType cpp compiler sun_cc

    " <localleader><F1> builds a single object
    au FileType cpp nnoremap <buffer> <silent> <localleader><F1> :call work_vm#LocalBuildToQuickFix()<CR>
    " <localleader><F2> issues a make in the folder containing the current file
    au FileType cpp nnoremap <buffer> <silent> <localleader><F2> :call work_vm#LocalMakeToQuickFix()<CR>
    " <localleader><F3> simply does a non-optimized recursive build
    "au FileType cpp nnoremap <buffer> <silent> <localleader><F3> :!buildtcc.sh<CR>
    au FileType cpp nnoremap <buffer> <silent> <localleader><F3> :call work_vm#BuildToQuickFix()<CR>
    " <localleader><F4> runs the current unit test, or the unit test for the current unit
    au FileType cpp nnoremap <buffer> <silent> <localleader><F4> :call work_vm#TestUnit()<CR>
    " <localleader><F5> runs QACPP on the lint host, for the current unit
    au FileType cpp nnoremap <buffer> <silent> <localleader><F5> :call work_vm#LintUnit()<CR>
    " <localleader><F6> deploys the system to the test server
    au FileType cpp nnoremap <buffer> <silent> <localleader><F6> :Dispatch buildtcc.sh<CR>
    " <localleader><F7> (re-)starts the system on the test server
    au FileType cpp nnoremap <buffer> <silent> <localleader><F7> :Dispatch deploytcc.sh<CR>
    " <localleader><F8> syncronize the source tree
    au FileType cpp nnoremap <buffer> <silent> <localleader><F8> :Dispatch runtcc.sh<CR>

    " <localleader>cci does a sanity check of the unit (todos, debug statements
    " and lint)
    au FileType cpp nnoremap <buffer> <silent> <localleader>cci <ESC>:call work_vm#CanCheckin()<CR>

    " <localleader>p lcd to project root
    au FileType cpp nnoremap <buffer> <silent> <localleader>p <ESC>:call work_vm#LcdToProjectRoot()<CR>

    " <localleader>uo for opening unit test
    au FileType cpp nnoremap <buffer> <silent> <localleader>uo <ESC>:call work_vm#OpenUnitTest(0)<CR>
    " <localleader>uO for opening unit test in new tab
    au FileType cpp nnoremap <buffer> <silent> <localleader>uO <ESC>:call work_vm#OpenUnitTest(1)<CR>


    " <localleader><F1> compiles the current markdown file to .pdf
    au FileType markdown nnoremap <buffer> <silent> <localleader><F1> :!compiledoc %<CR>
    " <localleader><F7> opens the pdf file corresponding to the current markdown
    au FileType markdown nnoremap <buffer> <silent> <localleader><F7> :!xdg-open %:p:r.pdf<CR>

    au BufWritePost * Neomake

    " keybindings and settings for working with ctags:
    "  If the g:current_work_project_path variable can be read from the
    "  configuration file that details the current project, then that directory
    "  will be used to store the tagsfile in.
    "
    " <localleader>ud updates the tagsfile
    call work_vm#ReadProjectVariables()
    if exists("g:current_work_project_path")
      exec 'au FileType cpp nnoremap <buffer> <silent> <localleader>ud :!ctags -R --exclude="*.sql" --exclude=".git" --exclude="*Test.?pp" --exclude="*[Ss]tub*.?pp" --exclude=Makefile --exclude=Documentation --c++-kinds=+p --fields=+iaS --extra=+q -f '.g:current_work_project_path.'/.tags '.g:current_work_project_path.'<CR>'
      exec 'set tags+='.g:current_work_project_path.'/.tags'
    else
      au FileType cpp nnoremap <buffer> <silent> <localleader>ud :!ctags -R --exclude='*.sql' --exclude='.git' --c++-kinds=+p --fields=+iaS --extra=+q . <CR>
    endif

  augroup END
endif

""" }}}
""" keybindings {{{
"""

" Navigate the help with the ä key, rather than the slightly awkward default
nnoremap ä <C-]>

" Allow for a more american-esque colon
nnoremap ö :

" vimgrep project
nnoremap <leader>gp :execute "vimgrep //j **/*/**/*.?pp"<left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left>

" vimgrep project for word under cursor
nnoremap <leader>gpw :execute "vimgrep /".expand('<cword>')."/j **/*/**/*.?pp"<left><left><left><left><left><left><left><left><left><left><left>
""" }}}
