set guifont=Cartograph\ CF:h10
set number
set hidden
command Root cd %:p:h:h
command File cd %:p:h
syntax on
set vb t_vb=
tnoremap <Esc> <C-\><C-n>
" colorscheme onedark

colorscheme Papercolor
set background=light

" set autochdir
autocmd BufEnter * silent! lcd %:p:h

command! Bd bp|bd #

let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
