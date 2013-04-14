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

" make g the default for :s replaces
set gdefault

" Highlight the current line
set cursorline

" Visually select the text that was last edited/pasted
nnoremap gV `[v`]

" Text options
"set colorcolumn=85

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

" gui options (gvim) ------------------------{{{
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

nnoremap <leader>v :sp $MYVIMRC<CR>

nnoremap <leader>n :call NumberToggle()<CR>

" \l : toggle visible whitespace
nnoremap <leader>l :set list!<CR>
set listchars=tab:»\ ,eol:¬
set list
" \s : toggle spell check
nnoremap <leader>s :set spell!<CR>

" \f : use par to form
"nmap <leader>f vip!par-format<CR>

" change foldmethod
nnoremap <leader>fs :set foldmethod=syntax<CR>
nnoremap <leader>fm :set foldmethod=marker<CR>
nnoremap <leader>fn :set foldmethod=manual<CR>

" \h : clear search highlights
nnoremap <leader>h :noh<CR>

" \ew : open from current dir
noremap <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
" \es : open in new window from current dir
noremap <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
" \ev : open in new vertical window from current dir
noremap <leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>
" \et : open in new tab from current dir
noremap <leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>

" quickfix maps
nnoremap <leader>cn :cn<CR>
nnoremap <leader>cp :cp<CR>

" New tab
nnoremap <leader>T :tabe<CR>

" ctags maps
nnoremap <leader>/ :ta /

" Make!
nnoremap <leader>m :silent make<CR>

" }}}

" Ranger integration ----------------------------{{{
fun! RangerChooser()
    silent !ranger --choosefile=/tmp/choosenfile $([ -z '%' ] && echo -n '.' || dirname %)
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

augroup filetype_haskell
    " Haskell
    au Bufenter *.hs compiler ghc
augroup END

augroup filetype_make
    autocmd!
    autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
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

" Ctrl - p open in tab/etc
let g:ctrlp_arg_map = 1

" <leader>cc clears quickfix list ---------------{{{
function! ClearQuickFixList()
    call setqflist([])
    cclose
endfunc
command! ClearQuickFixList call ClearQuickFixList()
nnoremap <leader>cq :ClearQuickFixList<CR>
" }}}

"Haskell ctags ----------------------{{{
function! HaskellCtags()
    ! echo ":ctags" | ghci -v0 %
endfunc
command! HaskellCtags call HaskellCtags()
" }}}

" Power line symbols use patched font.
let g:Powerline_symbols='fancy'
