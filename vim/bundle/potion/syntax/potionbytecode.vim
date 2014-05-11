if exists("b:current_syntax")
    finish
endif

syntax keyword pbKeyword move loadk loadbool loadnil getupval getglobal gettable
syntax keyword pbKeyword setglobal setupval settable newtable self
syntax keyword pbKeyword add sub mul div mod pow unm not len concat
syntax keyword pbKeyword jmp eq lt le test testset call tailcall return
syntax keyword pbKeyword forloop forprep tforloop setlist close closure vararg

syntax match pbComment "\v;.*$"

SYNTAX match pbNumber "\v\d+"

syntax match pbLineNumber "\v\[\s?\d+\]"

highlight link pbKeyword Keyword
highlight link pbComment Comment
highlight link pbNumber Number
highlight link pbLineNumber Function

let b:current_syntax = "potionbytecode"
