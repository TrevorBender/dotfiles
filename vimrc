" setup pathogen --------------{{{
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
" }}}

" VI Setting:
"
" enable syntax indent and filetype -------------{{{
syntax on
filetype on
filetype plugin on
filetype indent on
" }}}

" Line Numbers ----------------{{{
set nonumber
function! NumberToggle()
    if (&relativenumber ==1)
        set norelativenumber
    else
        set relativenumber
    endif
endfunc
" }}}

" Search Settings --------------{{{
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
" }}}

" Statusline -----------------{{{
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
set laststatus=2
"}}}

" Wildmenu ----------------------{{{
set wildmode=longest,full
set wildmenu
set wildignore+=*.class,.git,target/**,tags
" }}}

" G netrw browser settings -----{{{
let g:netrw_liststyle=3
let g:netrw_browse_split=4
let g:newrw_preview=1
" }}}
"


" list chars
"set listchars=tab:»»,eol:¬,trail:·
set listchars=tab:»»,trail:·
set list
"exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
"set list

" make g the default for :s replaces
set gdefault

" Highlight the current line
set cursorline

" Visually select the text that was last edited/pasted
nnoremap gV `[v`]

" Text options
"set colorcolumn=81
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

" ctags --------------------{{{
set tags=./tags;/
set tags=./tags,~/.tags
set complete=.,w,b,u,t,i
set dictionary+=/usr/share/dict/words
" }}}

" Indent settings -------------{{{
set cindent
set smartindent
set autoindent
set expandtab
set tabstop=4
set shiftwidth=4
" }}}

"  no menu
" gui options (gvim) ------------------------{{{
set guioptions-=m
"  no toolbar
set guioptions-=T
" no left scrollbar
set guioptions-=L
set guioptions-=l
" no right scrollbar
set guioptions-=r
set guioptions-=R
"  copy to window system selection
set guioptions+=a
set guioptions-=t
" Set the font
set guifont=Inconsolata\ 11
" gui only options
if has('gui_running')
    set lines=40
    set columns=95
    set background=light
endif
" Color Scheme -----------------------{{{
if (!has('gui,_running'))
    set t_Co=256
    let g:solarized_termcolors=256
    let g:solarized_termtrans=1
    colorscheme solarized
endif
" }}}
" }}}

" MAPPINGS
" Window movements using C-* ----------------{{{
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
" }}}

" goto tab (using gtk binds <alt-#>) ---------{{{
noremap <A-1> 1gt
noremap <A-2> 2gt
noremap <A-3> 3gt
noremap <A-4> 4gt
noremap <A-5> 5gt
noremap <A-6> 6gt
noremap <A-7> 7gt
noremap <A-8> 8gt
noremap <A-9> 9gt
" }}}

" MAPPINGS ----------------------------------------{{{
" change leader to ',' because it's easier to hit
" even though it overrides ',' : repeat last find in reverse
let mapleader = ","
let localleader = "\\"

" map space to toggle folds. So much more useful.
nnoremap <space> za

" edit vimrc
nnoremap <leader>v :e $MYVIMRC<CR>

" toggle relative line numbers
nnoremap <leader>n :call NumberToggle()<CR>

" toggle absolute line numbers
nnoremap <leader>N :set number!<CR>


" ,l : toggle visible whitespace
nnoremap <leader>l :set list!<CR>

" ,s : toggle spell check
nnoremap <leader>s :set spell!<CR>

" ,f : use par to form
"nnoremap <leader>f vip!par-format<CR>

" change foldmethod
nnoremap <leader>fs :set foldmethod=syntax<CR>
nnoremap <leader>fm :set foldmethod=marker<CR>
nnoremap <leader>fn :set foldmethod=manual<CR>

" ,h : clear search highlights
nnoremap <leader>h :noh<CR>

" ,ew : open from current dir
noremap <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
" ,es : open in new window from current dir
noremap <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
" ,ev : open in new vertical window from current dir
noremap <leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>
" ,et : open in new tab from current dir
noremap <leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>

" quickfix maps
nnoremap <leader>cn :cn<CR>
nnoremap <leader>cp :cp<CR>

" New tab
nnoremap <leader>T :tabe<CR>


" <leader>t to switch between expand tab and no expand tab
nnoremap <leader>t :set expandtab!<cr>

" ctags maps
nnoremap <leader>/ :ta /

" Make!
command! -nargs=* QMake make <args> | cwindow 3
nnoremap <leader>m :silent :QMake<CR>

" Always search using very magic
"nnoremap / /\v

" Highlight whitespace at the end of the line
nnoremap <localleader>w :match ErrorMsg /\v\s+$/<cr>
nnoremap <localleader>W :match none<cr>

" 'upercase word' mapping.
inoremap <c-u> <esc>mzgUiw`za

nnoremap <F5> :GundoToggle<CR>

" Quickfix Toggle <leader>q -------------------------{{{
nnoremap <leader>q :call <SID>QuickfixToggle()<cr>
let g:quickfix_is_open = 0
function! s:QuickfixToggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
        execute g:quickfix_return_to_window . "wincmd w"
    else
        let g:quickfix_is_open = 1
        let g:quickfix_return_to_window = winnr()
        copen
    endif
endfunction

"}}}
" foldcolumn toggle <leader>f ----------------------{{{
set foldcolumn=0
nnoremap <leader>f :call <SID>FoldColumnToggle()<cr>
function! s:FoldColumnToggle()
    if &foldcolumn
        set foldcolumn=0
    else
        set foldcolumn=1
    endif
endfunction
"}}}
" }}}

" Ranger integration ----------------------------{{{
fun! RangerChooser()
    if has('gui_running')
        ConqueTerm ranger --choosefile=/tmp/choosenfile $([ -z '%' ] && echo -n '.' || dirname %)
    else
        silent !ranger --choosefile=/tmp/choosenfile $([ -z '%' ] && echo -n '.' || dirname %)
    endif
    if filereadable('/tmp/choosenfile')
        exec 'edit ' . system('cat /tmp/choosenfile')
        call system('rm /tmp/choosenfile')
    endif
    redraw!
endfun
noremap <leader>r :call RangerChooser()<CR>
" }}}

" AUTOCMD s ----------------------------{{{
augroup filetype_jack
    " Treat .jack files as java
    autocmd BufNewFile,BufRead *.jack setfiletype java
augroup END

" Shader languages
augroup filetype_glsl
    " glsl
    autocmd BufNewFile,BufRead *.vert set syntax=glsl
    autocmd BufNewFile,BufRead *.frag set syntax=glsl
augroup END

augroup filetype_lex
    autocmd BufNewFile,BufRead *.flex set syntax=lex
augroup END


augroup filetype_gsp_md
    autocmd BufNewFile,BufRead *.md.gsp set syntax=markdown
augroup END

augroup filetype_haskell
    " Haskell
    autocmd!
    autocmd BufNewFile,BufRead .ghci setfiletype haskell
    autocmd Bufenter *.hs compiler ghc
    function! HaskellRun()
        write
        silent !clear
        if glob("*.cabal") != ''
            execute "!cabal run"
        else
            execute "!runghc " . bufname("%")
        endif
    endfunction
    autocmd BufNewFile,BufRead *.hs nnoremap <buffer> _r :call HaskellRun()<cr>
    function! HaskellRepl()
        write
        silent !clear
        execute "!ghci " . bufname('%')
    endfunction
    function! HaskellReplConque()
        execute "ConqueTerm ghci " . bufname('%')
    endfunction
    function! SetToCabalBuild()
        if glob("*.cabal") != ''
            set makeprg=cabal\ build
        endif
    endfunction
    autocmd BufEnter *.hs :call SetToCabalBuild()
    autocmd BufNewFile,BufRead *.hs nnoremap <buffer> _g :!ghci %<cr>
    autocmd BufNewFile,BufRead *.hs nnoremap <buffer> _G :call HaskellReplConque()<cr>
    autocmd BufNewFile,BufRead *.hs nnoremap <buffer> _R :Clam runhaskell %<cr>
    autocmd BufNewFile,BufRead *.hs nnoremap <buffer> _c :!ghc %<cr>
    autocmd BufNewFile,BufRead *.hs nnoremap <buffer> _h :Hoogle <C-R><C-W><CR>
augroup END

augroup filetype_make
    autocmd!
    autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
augroup END

augroup filetype_txt
    autocmd!
    function! ToggleHelp()
        if &filetype ==# 'help'
            set filetype=text
        else
            set filetype=help
        endif
    endfunction
    autocmd BufNewFile,BufRead *.txt nnoremap <buffer> <leader>H :call ToggleHelp()<cr>
augroup END

augroup filetype_hamlet
    autocmd!
    autocmd Bufenter *.hamlet set syntax=hamlet
augroup END

augroup filetype_clojure
    autocmd!
    autocmd BufNewFile,BufRead *.clj set syntax=clojure
    function! ClojureGrep(type)
        let saved_unnamed_register = @@
        if a:type ==# 'v'
            normal! `<v`>y
        elseif a:type ==# 'char'
            normal! `[v`]y
        else
            return
        endif
        silent execute "vimgrep /" . @@ . "/ **/*.clj"
        copen
        let @@ = saved_unnamed_register
    endfunction
    autocmd FileType clojure nnoremap cg :set operatorfunc=ClojureGrep<cr>g@
    autocmd FileType clojure vnoremap cg :<c-u>call GrepOperator(visualmode())<cr>
augroup END


" Fold on markers in vimscript ---------------{{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    " Source the vimrc file after saving it
    autocmd bufwritepost .vimrc source $MYVIMRC
    autocmd BufNewFile,BufRead .pentadactylrc set syntax=vim
augroup END
" }}}

" Fold on syntax in c/cpp ---------------------{{{
augroup filetype_c
    autocmd!
    autocmd FileType c setlocal foldmethod=syntax
    autocmd FileType cpp setlocal foldmethod=syntax
augroup END
" }}}
" }}}

" Tab Labels, Buffer names ------------------------------------{{{
" set up tab labels with tab number, buffer name, number of windows
function! GuiTabLabel()
  let label = ''
  let bufnrlist = tabpagebuflist(v:lnum)

  " Add '+' if one of the buffers in the tab page is modified
  for bufnr in bufnrlist
    if getbufvar(bufnr, "&modified")
      let label = '+'
      break
    endif
  endfor

  " Append the tab number
  let label .= v:lnum.': '

  " Append the buffer name
  let name = bufname(bufnrlist[tabpagewinnr(v:lnum) - 1])
  if name == ''
    " give a name to no-name documents
    if &buftype=='quickfix'
      let name = '[Quickfix List]'
    else
      let name = '[No Name]'
    endif
  else
    " get only the file name
    let name = fnamemodify(name,":t")
  endif
  let label .= name

  " Append the number of windows in the tab page
  let wincount = tabpagewinnr(v:lnum, '$')
  return label . '  [' . wincount . ']'
endfunction
set guitablabel=%{GuiTabLabel()}
" }}}

" cscope integration -------------------{{{
"if has("cscope")
    "set cprg=/usr/bin/cscope
    "set csto=0
    "set cst
    "set nocsverb
    " add any database in current directory
    "if filereadable("cscope.out")
        "cs add cscope.txt
        " else add database pointed to by environment
    "elseif $CSCOPE_DB != ""
        "cs add $CSCOPE_DB
    "endif
"endif
" }}}

" Haskell Settings
let g:haddock_browser = "firefox"
" haskell setting ?
let hs_highlight_delimiters = 1

function! Hoogle(str)
    execute "!" . g:haddock_browser . " http://www.haskell.org/hoogle/?hoogle=" . a:str
endfunction
command! -nargs=1 Hoogle call Hoogle(<f-args>)

" Ctrl - p open in tab/etc
let g:ctrlp_arg_map = 1

" <leader>cq clears quickfix list ---------------{{{
function! ClearQuickFixList()
    call setqflist([])
    cclose
endfunc
nnoremap <leader>cq :call ClearQuickFixList()<CR>
" }}}

"Haskell ctags ----------------------{{{
function! HaskellCtags()
    ! echo ":ctags" | ghci -v0 %
endfunc
command! HaskellCtags call HaskellCtags()
" }}}

" Power line symbols use patched font.
set rtp+=/home/trevor/git/powerline/powerline/bindings/vim
"let g:Powerline_symbols='fancy'

if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif
set noshowmode " Hide the default mode text (e.g. -- INSERT -- )

let g:SuperTabMappingForward = '<tab>'
let g:SuperTabMappingBackward = '<s-tab>'
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:SuperTabContextDefaultCompletiontype = "<c-n>"

" Clam settings ----------{{{
nnoremap ! :Clam<space>
vnoremap ! :ClamVisual<space>
" }}}


" Search highlight
nnoremap <silent> n   n:call HLNext(0.4)<cr>
nnoremap <silent> N   N:call HLNext(0.4)<cr>
function! HLNext (blinktime)
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    let target_pat = '\c\%#'.@/
    let ring = matchadd('ColorColumn', target_pat, 101)
    redraw
    exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
    call matchdelete(ring)
    redraw
endfunction
