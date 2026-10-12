setlocal wrap linebreak tw=0 spell cursorlineopt=number spellcapcheck=
exe 'setlocal spellfile=' . expand('%:p:h') . '/words.utf-8.add'
nnoremap <buffer> j gj
nnoremap <buffer> k gk
noremap  <buffer> <Down> gj
noremap  <buffer> <Up>   gk
inoremap <buffer> <Down> <C-o>gj
inoremap <buffer> <Up>   <C-o>gk
