if !exists('g:potion_command')
    let g:potion_command = 'potion'
endif

function! potion#running#PotionCompileAndRunFile()
    write
    silent !clear
    execute "!" . g:potion_command . " " . bufname("%")
endfunction

function! potion#running#PotionShowByteCode()
    " check if the buffer is a potion file?
    write
    " Get the bytecode.
    let bytecode = system(g:potion_command . " -c -V " . bufname('%'))
    if v:shell_error
        echom 'error compiling ' . expand('%')
        return
    endif

    " Open a new split and set it up.
    let byteCodeWinNr = bufwinnr('__Potion_Bytecode__')
    if byteCodeWinNr ==# -1
        vsplit __Potion_Bytecode__
    else
        execute 'silent ' byteCodeWinNr . 'wincmd w'
    endif

    normal! ggdG
    setlocal filetype=potionbytecode
    setlocal buftype=nofile

    " Insert the bytecode.
    call append(0, split(bytecode, '\v\n'))
endfunction

nnoremap <buffer> <localleader>r :call potion#running#PotionCompileAndRunFile()<cr>

nnoremap <buffer> <localleader>b :call potion#running#PotionShowByteCode()<cr>

