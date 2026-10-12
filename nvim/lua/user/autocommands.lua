vim.cmd [[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR> 
    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200}) 
    autocmd BufWinEnter * :set formatoptions-=cro
    autocmd FileType qf set nobuflisted
    autocmd BufRead * autocmd FileType <buffer> ++once if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif
  augroup end

  augroup _git
    autocmd!
    autocmd FileType gitcommit setlocal wrap
    autocmd FileType gitcommit setlocal spell
  augroup end

  augroup _markdown
    autocmd!
    autocmd FileType markdown setlocal tw=70
    autocmd FileType markdown setlocal wrap
    autocmd FileType markdown setlocal spell
  augroup end

  augroup _auto_resize
    autocmd!
    autocmd VimResized * tabdo wincmd = 
  augroup end

  augroup _alpha
    autocmd!
    autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
  augroup end

  augroup ebnf
    autocmd!
    autocmd BufRead,BufNewFile *.ebnf set filetype=ebnf
  augroup end

  augroup _book
    autocmd!
    autocmd BufRead,BufNewFile *.book set filetype=book
    autocmd FileType book setlocal wrap linebreak tw=0
    autocmd FileType book setlocal spell
    autocmd FileType book setlocal spellcapcheck=
    autocmd FileType book setlocal cursorlineopt=number
    autocmd FileType book nnoremap <buffer> j gj
    autocmd FileType book nnoremap <buffer> k gk
    autocmd FileType book noremap  <buffer> <Down> gj
    autocmd FileType book noremap  <buffer> <Up>   gk
    autocmd FileType book inoremap <buffer> <Down> <C-o>gj
    autocmd FileType book inoremap <buffer> <Up>   <C-o>gk
    autocmd FileType book exe 'setlocal spellfile=' . expand('%:p:h') . '/words.utf-8.add'
  augroup end

  augroup _text
    autocmd!
    autocmd FileType text setlocal tw=70
    autocmd FileType text setlocal spell
  augroup end
]]

-- Autoformat
-- augroup _lsp
--   autocmd!
--   autocmd BufWritePre * lua vim.lsp.buf.formatting()
-- augroup end
