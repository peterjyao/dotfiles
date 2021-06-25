language en
set guifont=Cartograph\ CF:h10
set number
" set colorcolumn=81
set hidden
tnoremap <Esc> <C-\><C-n>
command Root cd %:p:h:h
command File cd %:p:h
syntax on

let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}

" colorscheme onedark

" set laststatus=0

" Clear cmd line message
" function! s:empty_message(timer)
"   if mode() ==# 'n'
"     echon ''
"   endif
" endfunction
" 
" augroup cmd_msg_cls
"     autocmd!
"     autocmd CmdlineLeave :  call timer_start(5000, funcref('s:empty_message'))
" augroup END" set autochdir

" autocmd BufEnter * silent! lcd %:p:h

