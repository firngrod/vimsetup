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
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:statline_syntastic = 0
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
nnoremap <leader>qq :q!<CR>
nnoremap <leader>qa :qa!<CR>
nnoremap <leader>qw :wa!<CR>:qa<CR>

" Windows-like Copy-Paste
vnoremap <leader>c "ty
vnoremap <leader>v "tp
nnoremap <leader>c viw"ty
nnoremap <leader>vw viw"tp
nnoremap <leader>vv "tp

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
