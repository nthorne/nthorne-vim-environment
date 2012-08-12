""" pyeval.vim
"""   - function for evaluating marked code snippets as python code
"""     (http://jeetworks.org/node/146)


command! -bang -range EvalPy :call pyeval#EvaluateCurrentRangeAsMarkedUpPython("<bang>")
