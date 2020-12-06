if exists('g:loaded_saihenkan')
  finish
endif
let g:loaded_saihenkan = 1
let s:save_cpo = &cpo
set cpo&vim

command! -nargs=+ -complete=file Saihenkan :call saihenkan#Saihenkan(0, <q-args>)
" vnoremap <silent> <C-k>     :<C-u>Saihenkan ~/Downloads/skk-jisyo/SKK-JISYO.L.txt<CR>
" nnoremap <silent> <C-k>  viw:<C-u>Saihenkan ~/Downloads/skk-jisyo/SKK-JISYO.L.txt<CR>
" vnoremap <silent> k         :<C-u>Saihenkan ~/Downloads/skk-jisyo/SKK-JISYO.itaiji.txt<CR>

let &cpo = s:save_cpo
unlet s:save_cpo
