vim.cmd [[
try
  colorscheme tokyonight-night
  hi! link @constant.builtin @constant
  hi @lsp.type.selfTypeKeyword gui=italic
  hi! link @lsp.typemod.variable.constant @constant
  hi IlluminatedWordRead ctermbg=NONE guibg=NONE gui=underline
  hi IlluminatedWordText ctermbg=NONE guibg=NONE gui=underline
  hi IlluminatedWordWrite ctermbg=NONE guibg=NONE gui=underline
  hi LspReferenceRead ctermbg=NONE guibg=NONE gui=underline
  hi LspReferenceText ctermbg=NONE guibg=NONE gui=underline
  hi LspReferenceWrite ctermbg=NONE guibg=NONE gui=underline

catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
