imap <C-Return> <CR><CR><C-o>k<Tab>
" For repeat for each line on . in visual mode
vnoremap . :norm.<CR>

" Avoid that ESC key
vnoremap hkl <ESC>
inoremap hkl <ESC>

" No mouse!
set mouse=""

let mapleader = "\<Space>"
set autoindent
set smartindent
set tabstop=2 shiftwidth=2 expandtab
syntax on



if filereadable(expand("~/.vim/autoload/pathogen.vim"))
  runtime! autoload/pathogen.vim
  if exists("g:loaded_pathogen")
    execute pathogen#infect()
  endif
endif


set hlsearch
let g:statline_syntastic = 0
let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = ' -std=c++14 -I ../Libs/'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
filetype plugin on
hi Type ctermfg=Cyan guifg=Cyan
hi Comment ctermfg=Green guifg=Green

" Shortcuts to the VIMRC
nnoremap <leader>ev :e ~/.vimrc<CR>
nnoremap <leader>sv :so ~/.vimrc<CR>

" Toggle line numbers
nnoremap <leader>i :set number!<CR>

" General shortcuts
nnoremap <leader>ww :w<CR>
nnoremap <leader>wa :wa<CR>
nnoremap <leader>wq :wq<CR>
nnoremap <leader>qq :q!<CR>
nnoremap <leader>qa :qa!<CR>
nnoremap <leader>qw :wa!<CR>:qa<CR>
nnoremap <leader>lw :set wrap!<CR>

" Windows-like Copy-Paste
vnoremap <leader><leader>c "ty
vnoremap <leader><leader>v "tp
vnoremap <leader><leader>x "td
nnoremap <leader><leader>c viw"ty
nnoremap <leader><leader>w viw"tp
nnoremap <leader><leader>v "tp
nnoremap <leader><leader><S-v> "tP
nnoremap <leader><leader>x viw"td
inoremap jkjkv <C-o>"tP

" Window naviagation
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

" Buffer navigation
nnoremap <leader>b :buffers<CR>:b! 
nnoremap <leader>n :bn<CR>
nnoremap <leader>p :bp<CR>



" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

let @n=':NERDTree .'
let @m=':wa:!sh -c "make -j8 test & read"'
let @c=':wa:!sh -c "make clean; make -j8; read"'
let @b=':wa:!sh -c "make; read"'

function! MarkWindowSwap()
  let g:markedWinNum = winnr()
endfunction

function! DoWindowSwap()
  "Mark destination
  let curNum = winnr()
  let curBuf = bufnr( "%" )
  exe g:markedWinNum . "wincmd w"
  "Switch to source and shuffle dest->source
  let markedBuf = bufnr( "%" )
  "Hide and open so that we aren't prompted and keep history
  exe 'hide buf' curBuf
  "Switch to dest and shuffle source->dest
  exe curNum . "wincmd w"
  "Hide and open so that we aren't prompted and keep history
  exe 'hide buf' markedBuf 
endfunction

nmap <silent> <leader>mw :call MarkWindowSwap()<CR>
nmap <silent> <leader>pw :call DoWindowSwap()<CR>
nmap <silent> <leader>s :so ~/.vimrc<CR>

" Fold handling
"set foldmethod=syntax   
"set foldnestmax=10
"set foldlevel=2

nnoremap <silent> <leader>fj :call NextClosedFold('j')<cr>
nnoremap <silent> <leader>fk :call NextClosedFold('k')<cr>
nnoremap <silent> <leader>fh za
nnoremap <silent> <leader>fl zA
function! NextClosedFold(dir)
  let cmd = 'norm!z' . a:dir
  let view = winsaveview()
  let [l0, l, open] = [0, view.lnum, 1]
  while l != l0 && open
    exe cmd
    let [l0, l] = [l, line('.')]
    let open = foldclosed(l) < 0
  endwhile
  if open
    call winrestview(view)
  endif
endfunction
