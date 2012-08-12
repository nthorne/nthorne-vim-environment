""" pyeval.vim
"""   - function for evaluating marked code snippet as python code
"""     (http://jeetworks.org/node/146)


" function! common#EvaluateCurrentRangeAsMArkedUpPython() {{{
"   Evecute currently selected visual range as Python. Lines are pre-processed
"   to remove extra indentation, leaders, or decorators that might be in place
"   due to the line range being part of a code block in a mark-up language
"   document (such as ReStructured Text, Markdown, etc.)
"
" arguments:
"   insert_result - if set, result will be inserted into the current buffer
" returns:
"   - 
function! pyeval#EvaluateCurrentRangeAsMarkedUpPython(insert_results) range
    "" get lines
    let [lnum1, col1] = getpos("'<")[1:2]
    let [lnum2, col2] = getpos("'>")[1:2]
    let lines = getline(lnum1, lnum2)
    " let lines[-1] = lines[-1][: col2 - 2]
    " let lines[0] = lines[0][col1 - 1:]

    "" remove blank rows
    let rows = []
    for line in lines
        let row = substitute(line, '^\s*\(.\{-}\)\s*$', '\1', '')
        if len(row) > 0
            call add(rows, line)
        endif
    endfor
    let lines = rows

    if len(lines) == 0
        return
    endif
    let leader = matchstr(lines[0], '^\s*\(>>>\|\.\.\.\)\{0,1}\s*')
    let leader_len = len(leader)
    let code_lines = []
    for line in lines
        let code_line = strpart(line, leader_len)
        call add(code_lines, code_line)
    endfor
    let code = join(code_lines, "\n")
    if empty(a:insert_results)
        call common#OpenBuffer('pyeval')
        %d
        execute "r !python -c " . shellescape(code)
        1d
    else
        let endpos = getpos("'>")
        call setpos('.', endpos)
        execute "r !python -c " . shellescape(code)
    endif
endfunction
" }}}
