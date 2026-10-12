vim.filetype.add { extension = { book = "book", ebnf = "ebnf" } }

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function(args)
    local root = vim.bo[args.buf].buftype == "" and vim.fs.root(args.buf, ".git")
    if root then
      vim.fn.chdir(root)
    end
  end,
})

vim.cmd [[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man nnoremap <silent> <buffer> q :close<CR>
    autocmd TextYankPost * lua vim.hl.on_yank { higroup = 'Visual', timeout = 200 }
    autocmd BufWinEnter * :set formatoptions-=cro
    autocmd FileType qf set nobuflisted
    autocmd BufRead * autocmd FileType <buffer> ++once if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif
  augroup end

  augroup _auto_resize
    autocmd!
    autocmd VimResized * wincmd =
  augroup end

  augroup _alpha
    autocmd!
    autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
  augroup end
]]
