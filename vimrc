" setup pathogen
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" VI Setting:
"
" Line Numbers
set nu
"set relativenumber

" Search Settings
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch

" make g the default for :s replaces
set gdefault

" Color Scheme
"colorscheme molokai
if (!has('gui_running'))
    echo "console"
    "set t_Co=256
    if (&t_Co == 256)
        echo "256 colors"
    endif
    if (&t_Co == 88)
        echo "88 colors"
    endif
endif
if ((&t_Co == 256 || &t_Co == 88) && !has('gui_running'))
    GuiColorScheme molokai
else
    colorscheme molokai
endif

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
set guioptions-=Ll
" no right scrollbar
set guioptions-=r
set guioptions-=R
"  copy to window system selection
set guioptions+=a
set guioptions-=t

" Highlight the current line
set cursorline

" Set the font
set guifont=Inconsolata\ Medium\ 12

set tags=./tags,~/.tags
set complete=.,w,b,u,t,i
set dictionary+=/usr/share/dict/words

" Mappings

" Window movements using C-*
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" goto tab (using gtk binds <alt-#>)
map <A-1> 1gt
map <A-2> 2gt
map <A-3> 3gt
map <A-4> 4gt
map <A-5> 5gt
map <A-6> 6gt
map <A-7> 7gt
map <A-8> 8gt
map <A-9> 9gt

" change leader to ',' because it's easier to hit
let mapleader = ","
let localleader = "\\"

nmap <leader>v :sp $MYVIMRC<CR>

" \l : toggle visible whitespace
nmap <leader>l :set list!<CR>
" \s : toggle spell check
nmap <leader>s :set spell!<CR>

" \f : use par to form
nmap <leader>f vip!par-format<CR>

" \h : clear search highlights
nmap <leader>h :noh<CR>

" \ew : open from current dir
map <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
" \es : open in new window from current dir
map <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
" \ev : open in new vertical window from current dir
map <leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>
" \et : open in new tab from current dir
map <leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Visually select the text that was last edited/pasted
nmap gV `[v`]

" Only do this part when compiled with support for auto commands
if has("autocmd")
    filetype on

    autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab

    " Treat .jack files as java
    autocmd BufNewFile,BufRead *.jack setfiletype java

    " Source the vimrc file after saving it
    autocmd bufwritepost .vimrc source $MYVIMRC
endif

if has('gui_running')
    set lines=40
    set columns=95
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
