" setup pathogen {{{
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
" }}}

" VI Setting:
"

" Enable per-directory .vimrc files
set exrc
set secure

" short messages
set shortmess=atToOI

" enable syntax and filetype {{{
syntax enable
filetype on
filetype plugin on
filetype indent on
" }}}

" Line Numbers {{{
set nonumber
set norelativenumber
function! NumberToggle()
    if (&relativenumber ==1)
        set norelativenumber
        set nonumber
    else
        set relativenumber
        set number
    endif
endfunc
" }}}

" Search Settings {{{
set ignorecase
set smartcase
set incsearch       " search as characters are entered
set hlsearch        " hilight matches
" }}}

" Statusline {{{
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
set laststatus=2
"}}}

" Wildmenu {{{
set wildmode=longest,full
set wildmenu
set wildignore+=*.class,.git,target/**,tags,*.o,*.swp
" }}}

" G netrw browser settings {{{
let g:netrw_liststyle=3
let g:netrw_browse_split=4
let g:newrw_preview=1
" }}}
"

" list chars
set listchars=tab:»\ ,nbsp:_,trail:·
" ,eol:¬
set list

" make g the default for :s replaces
set gdefault

" Highlight the current line
set cursorline

" When a file has been changed outside of vim, reload it automatically
set autoread

" Visually select the text that was last edited/pasted
nnoremap gV `[v`]

" Don't redraw during macros
set lazyredraw

" Show matching {[ etc
set showmatch

" Fix line joins, using formatting
set formatoptions+=j

" ctags {{{
set tags=./tags;/
set tags=./tags,~/.tags
set complete=.,w,b,u,t,i
set dictionary+=/usr/share/dict/words
" }}}

" Indent settings {{{
set cindent
set smartindent
set autoindent
set expandtab
set tabstop=4
set shiftwidth=4
" }}}

" gui options (gvim) {{{
" gui only options
if has('gui_running')
    "  no menu
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
    set guifont=Inconsolata\ 12
    set lines=40
    set columns=95
    set background=light

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
endif

" }}}

" console settings: {{{

" Console Color Scheme {{{
if (!has('gui_running'))
    set t_Co=256
    let g:solarized_termcolors=256
    let g:solarized_termtrans=1
    colorscheme solarized
endif
" }}}

if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        autocmd InsertEnter * set timeoutlen=0
        autocmd InsertLeave * set timeoutlen=1000
    augroup END
endif
" }}}

" {{{ GVIM Settings:

if has('gui_running')
    colorscheme solarized

endif
" }}}

" MAPPINGS
" Window movements using C-* ----------------{{{
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C--> <C-w>-
" }}}

" MAPPINGS {{{
" change leader to ',' because it's easier to hit
" even though it overrides ',' : repeat last find in reverse
let mapleader = ","
let localleader = "\\"

" map space to toggle folds. So much more useful.
nnoremap <space> za

" edit vimrc
nnoremap <leader>v :e $MYVIMRC<CR>

" toggle line numbers
nnoremap <leader>n :call NumberToggle()<CR>

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
nnoremap <leader>m :make!<CR>

" Always search using very magic
"nnoremap / /\v

" Highlight whitespace at the end of the line
nnoremap <localleader>w :match ErrorMsg /\v\s+$/<cr>
nnoremap <localleader>W :match none<cr>

" 'upercase word' mapping.
inoremap <c-y> <esc>mzgUiw`za

nnoremap <leader>w :w<cr>
nnoremap <leader>o :CtrlP<CR>

" Quickfix Toggle <leader>q {{{
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
" foldcolumn toggle <leader>f {{{
set foldcolumn=0
nnoremap <leader>f :call <SID>FoldColumnToggle()<cr>
function! s:FoldColumnToggle()
    if &foldcolumn
        set foldcolumn=0
    else
        set foldcolumn=1
    endif
endfunction
" }}}
" }}}

" Ranger integration {{{
fun! RangerChooser()
    if has('gui_running')
        ConqueTerm fm --choose-file /tmp/choosenfile $([ -z '%' ] && echo -n '.' || dirname %)
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

" AUTOCMD's {{{
augroup filetype_vue
    autocmd!
    autocmd BufNewFile,BufRead *.vue set filetype=vue
augroup END

augroup filetype_toml
    autocmd!
    autocmd BufNewFile,BufRead *.toml set filetype=toml
augroup END

augroup filetype_go
    autocmd!
    autocmd BufNewFile,BufRead *.go set nolist
    autocmd BufNewFile,BufRead *.go set noexpandtab
    autocmd BufNewFile,BufRead *.go nnoremap <leader>t :GoTest<cr>
augroup END

augroup filetype_pug
    autocmd!
    autocmd BufNewFile,BufRead *.pug set filetype=pug tabstop=2 shiftwidth=2
augroup END

augroup filetype_styl
    autocmd!
    autocmd BufNewFile,BufRead *.styl set filetype=stylus tabstop=2 shiftwidth=2
augroup END

augroup filetype_jack
    " Treat .jack files as java
    autocmd!
    autocmd BufNewFile,BufRead *.jack set filetype=java
augroup END

"augroup filetype_jsx
    "autocmd!
    "autocmd BufNewFile,BufRead *.js set filetype=jsx
"augroup END

augroup filetype_typescript
    autocmd!
    autocmd BufNewFile,BufRead *.ts set filetype=typescript
    autocmd FileType typescript setlocal ts=2 sw=2 sts=2
augroup END

" Shader languages
augroup filetype_glsl
    " glsl
    autocmd!
    autocmd BufNewFile,BufRead *.vert set syntax=glsl
    autocmd BufNewFile,BufRead *.frag set syntax=glsl
    autocmd BufNewFile,BufRead *.glsl set syntax=glsl
augroup END

augroup filetype_lex
    autocmd!
    autocmd BufNewFile,BufRead *.flex set syntax=lex
augroup END

"augroup filetype_haskell
    "" Haskell
    "autocmd Bufenter *.hs compiler ghc
"augroup END

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

augroup filetype_pony
    autocmd!
    autocmd BufNewFile,BufRead *.pony set filetype=pony
augroup END

" Fold on markers in vimscript {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    " Source the vimrc file after saving it
    autocmd bufwritepost .vimrc source $MYVIMRC
    autocmd BufNewFile,BufRead .pentadactylrc set syntax=vim
augroup END
" }}}

" Fold on syntax in c/cpp (disabled) {{{
"augroup filetype_c
    "autocmd!
    "autocmd FileType c setlocal foldmethod=syntax
    "autocmd FileType cpp setlocal foldmethod=syntax
"augroup END
" }}}
" }}}

" Tab Labels, Buffer names {{{
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

" cscope integration {{{
if has("cscope")
    "set cprg=/usr/bin/cscope
    set csto=0
    set cst
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.txt
        "else  add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
endif
" }}}

" Haskell Settings {{{
let g:haddock_browser = "firefox"
" haskell setting ?
let hs_highlight_delimiters = 1
" }}}

" Ctrl - p open in tab/etc {{{
let g:ctrlp_arg_map = 1
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:100,results:100'
" }}}

" <leader>cq clears quickfix list {{{
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

" Clojure: {{{
let g:vimclojure#HighlightBuiltins = 1
let g:vimclojure#ParenRainbow = 1
let vimclojure#NailgunClient = "/home/trevor/bin/ng"
let vimclojure#WantNailgun = 1
" }}}

" YCM: {{{
let g:ycm_confirm_extra_conf = 0
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_autoclose_preview_window_after_insertion = 1
"let g:ycm_enable_diagnostic_signs = 0
let g:ycm_warning_symbol = '> '
if !exists("g:ycm_semantic_triggers")
    let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['typescript'] = ['.']

" DEBUG
"let g:ycm_keep_logfiles = 1
"let g:ycm_log_level = 'debug'

" }}}

" tsugyomi (typescript) {{{

" Disable quickfix on save
"let g:tsuquyomi_disable_quickfix = 1

" Fix tsugyomi default mapping removing ctrl-^ binding
let g:tsuquyomi_disable_default_mappings = 0
augroup tsuguyomi
    autocmd!
    autocmd BufNewFile,BufEnter *.ts map <buffer> <C-]> <Plug>(TsuquyomiDefinition)
    autocmd BufNewFile,BufEnter *.ts map <buffer> <C-t> <Plug>(TsuquyomiGoBack)
augroup END

let g:typescript_compiler_binary = 'tsc'
let g:typescript_compiler_options = ''
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

" }}}

" Emmet
let g:user_emmet_leader_key='<C-Z>'

" HEX EDITOR: {{{
let $in_hex = 0
function! Hex()
    if $in_hex > 0
        :%!xxd -r
        set binary
        set noeol
        let $in_hex = 0
    else
        :%!xxd
        let $in_hex = 1
    endif
endfunction
nnoremap <leader>x :call Hex()<cr>
" }}}

" Syntasic: {{{
let g:syntasic_vim_checkers = ['vint']
let g:syntastic_typescript_checkers = ['tsuquyomi']
"let g:syntastic_mode_map = {
			"\ "mode": "active",
			"\ "active_filetypes": [],
			"\ "passive_filetypes": ["go"] }
" }}}

" Tabular {{{
vmap <leader>a, :Tabularize comma<CR>
vmap <leader>a/ :Tabularize comment<CR>
" }}}
" Dart
if has('vim_starting')
    set nocompatible
    set runtimepath+=~/.vim/bundle/dart
endif

" Rust
let g:racer_experimental_completer = 1
au FileType rust nmap gd <Plug>(rust-def)

" Status Line: {{{

" Status Function: {{{

function! Status(winnr)
    let stat = ''
    let active = winnr() == a:winnr
    let buffer = winbufnr(a:winnr)
    let modified = getbufvar(buffer, '&modified')
    let readonly = getbufvar(buffer, '&ro')
    let fname = bufname(buffer)
    function! Color(active, num, content)
        if a:active
            return '%' . a:num . '*' . a:content . '%*'
        else
            return a:content
        endif
    endfunction
    " column
    let stat .= '%1*' . (col(".") / 100 >= 1 ? '%v ' : ' %2v ') . '%*'
    " file
    let stat .= Color(active, 4, active ? ' »' : ' «')
    let stat .= ' %<'
    if fname == '__Gundo__'
        let stat .= 'Gundo'
    elseif fname == '__Gundo_Preview__'
        let stat .= 'Gundo Preview'
    else
        let stat .= '%f'
    endif
    let stat .= ' ' . Color(active, 4, active ? '«' : '»')
    " file modified
    let stat .= Color(active, 2, modified ? ' +' : '')
    " read only
    let stat .= Color(active, 2, readonly ? ' ‼' : '')
    " paste
    if active && &paste
        let stat .= ' %2*' . 'P' . '%*'
    endif
    " right side
    let stat .= '%='
    " git branch
    if exists('*fugitive#head')
        let head = fugitive#head()
        if empty(head) && exists('*fugitive#detect') && !exists('b:git_dir')
            call fugitive#detect(getcwd())
            let head = fugitive#head()
        endif
    endif
    if !empty(head)
        let stat .= Color(active, 3, ' ← ') . head . ' '
    endif
    return stat
endfunction
" }}}
" Status AutoCMD: {{{
function! SetStatus()
    for nr in range(1, winnr('$'))
        call setwinvar(nr, '&statusline', '%!Status('.nr.')')
    endfor
endfunction
augroup status
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter,BufUnload * call SetStatus()
augroup END
" }}}

" Status Colors: {{{
hi! User1 ctermfg=33  ctermbg=239 cterm=bold
hi! User2 ctermfg=125 ctermbg=239 cterm=bold
hi! User3 ctermfg=64  ctermbg=239 cterm=bold
hi! User4 ctermfg=37  ctermbg=239 cterm=bold
" }}}

" Change status line on insert mode
" 4 - blue
" 15 - default
au InsertEnter * hi StatusLine ctermbg=4
au InsertLeave * hi StatusLine ctermbg=15
set noshowmode

"Change cursor line on insert mode
"187 - default
" 7 - white
" 8 - inverse
" 150  green
"
au InsertEnter * hi CursorLine ctermbg=150
au InsertLeave * hi CursorLine ctermbg=187


" }}}
