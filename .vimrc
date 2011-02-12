set nu
set ignorecase
set smartcase
set incsearch
colorscheme blackboard

set cindent
set smartindent
set autoindent
set expandtab
set tabstop=4
set shiftwidth=4

set guioptions-=m
set guioptions-=T

set guioptions-=Ll
set guioptions+=Rr

set guioptions+=a

set guioptions-=t

set cursorline

set guifont=Inconsolata\ Bold\ 9

set tags=~/.tags
set complete=.,w,b,u,t,i
set dictionary+=/usr/share/dict/words

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

nmap <leader>l :set list!<CR>

map <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Only do this part when compiled with support for autocommands
if has("autocmd")
    filetype on

    autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab

    " Treat .jack files as java
    autocmd BufNewFile,BufRead *.jack setfiletype java
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
