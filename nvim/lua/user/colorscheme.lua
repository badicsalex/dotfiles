vim.cmd [[
try
  colorscheme monokai_ad
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
