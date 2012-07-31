" setup pathogen
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" VI Setting:
"
" Line Numbers
" set nu
set relativenumber
function! NumberToggle()
    if (&relativenumber ==1)
        set nu
    else
        set relativenumber
    endif
endfunc

" Search Settings
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch

" Statusline
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
set laststatus=2

" Wildmenu
set wildmode=longest,full
set wildmenu
set wildignore+=*.class,.git,target/**,tags

" G netrw browser settings
let g:netrw_liststyle=3
let g:netrw_browse_split=4
let g:newrw_preview=1


" make g the default for :s replaces
set gdefault

" ctags
set tags=./tags;/

" Color Scheme
"colorscheme molokai
if (!has('gui,_running'))
    set t_Co=256
    let g:solarized_termcolors=256
    let g:solarized_termtrans=1
    colorscheme solarized
endif
"colorscheme molokai
set background=dark
"
" Indent settings
set cindent
set smartindent
set autoindent
set expandtab
set tabstop=4
set shiftwidth=4

" Text options
set colorcolumn=85

" gui options (gvim)
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

" Highlight the current line
set cursorline

" Set the font
set guifont=Inconsolata\ 11

set tags=./tags,~/.tags
set complete=.,w,b,u,t,i
set dictionary+=/usr/share/dict/words

" Mappings

" Window movements using C-*
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" goto tab (using gtk binds <alt-#>)
noremap <A-1> 1gt
noremap <A-2> 2gt
noremap <A-3> 3gt
noremap <A-4> 4gt
noremap <A-5> 5gt
noremap <A-6> 6gt
noremap <A-7> 7gt
noremap <A-8> 8gt
noremap <A-9> 9gt

" change leader to ',' because it's easier to hit
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

" ctags maps
nnoremap <leader>/ :ta /

" Make!
nnoremap <leader>m :silent make<CR>

" Ranger integration
fun! RangerChooser()
    silent !ranger --choosefile=/tmp/choosenfile $([ -z '%' ] && echo -n '.' || dirname %)
    if filereadable('/tmp/choosenfile')
        exec 'edit ' . system('cat /tmp/choosenfile')
        call system('rm /tmp/choosenfile')
    endif
    redraw!
endfun
noremap <leader>r :call RangerChooser()<CR>

" Visually select the text that was last edited/pasted
nnoremap gV `[v`]

" Only do this part when compiled with support for auto commands
if has("autocmd")
    filetype on

    autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab

    " Treat .jack files as java
    autocmd BufNewFile,BufRead *.jack setfiletype java

    " Source the vimrc file after saving it
    autocmd bufwritepost .vimrc source $MYVIMRC

    autocmd bufwritepost *.c,*.cpp,*.h silent! !ctags -R * &

    " glsl
    autocmd BufNewFile,BufRead *.vert set syntax=glsl
    autocmd BufNewFile,BufRead *.frag set syntax=glsl
endif

if has('gui_running')
    set lines=40
    set columns=95
    colorscheme solarized
    set background=dark
endif

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

" enable stuff
syntax on
filetype plugin on
filetype indent on

" cscope integration
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

au Bufenter *.hs compiler ghc

let g:haddock_browser = "firefox"

let g:ctrlp_arg_map = 1

"<leader>cc clears quickfix list
function! ClearQuickFixList()
    call setqflist([])
    cclose
endfunc
command! ClearQuickFixList call ClearQuickFixList()
nnoremap <leader>cq :ClearQuickFixList<CR>
