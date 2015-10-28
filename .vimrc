imap <C-Return> <CR><CR><C-o>k<Tab>
" For repeat for each line on . in visual mode
vnoremap . :norm.<CR>
inoremap hkl <ESC>
let mapleader = "\<Space>"
set autoindent
set tabstop=2 shiftwidth=2 expandtab
syntax on
execute pathogen#infect()
set hlsearch
let g:statline_syntastic = 0
let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -I ../Libs/'
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
nnoremap <leader>ev :split ~/.vimrc<CR>
nnoremap <leader>sv :so ~/.vimrc<CR>

" General shortcuts
nnoremap <leader>ww :w<CR>
nnoremap <leader>wa :wa<CR>
nnoremap <leader>wq :wq<CR>
nnoremap <leader>qq :q!<CR>
nnoremap <leader>qa :qa!<CR>
nnoremap <leader>qw :wa!<CR>:qa<CR>

" Windows-like Copy-Paste
vnoremap <leader><leader>c "ty
vnoremap <leader><leader>v "tp
vnoremap <leader><leader>x "td
nnoremap <leader><leader>c viw"ty
nnoremap <leader><leader>w viw"tp
nnoremap <leader><leader>v "tp
nnoremap <leader><leader><S-v> "tP
nnoremap <leader><leader>x viw"td

" Window naviagation
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l


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
let @m=':wa:!sh -c "make all & read"'

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
