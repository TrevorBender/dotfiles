" Add manual fold from line1 to line2, inclusive.
function! s:Fold(line1, line2)
    if a:line1 < a:line2
        execute a:line1.','.a:line2.'fold'
    endif
endfunction

" Return list of line numbers for current buffer found in quickfix list.
function! s:GetHitLineNumbers()
    let result = []
    for d in getqflist()
        if d.valid && d.bufnr == bufnr('')
            call add(result, d.lnum)
        endif
    endfor
    return result
endfunction

function! s:FoldMisses()
    setlocal foldmethod=manual
    normal! zE
    if exists('g:context')
        let extra = g:context
    else
        let extra = 0
    endif
    let last = 0
    for lnum in
        s:GetHitLineNumbers()
        call
        s:Fold(last+1+extra,
        lnum-1-extra)
        let last = lnum
    endfor
    call
    s:Fold(last+1+extra,
    line('$'))
endfunction
command!  FoldMisses call <SID>FoldMisses()
