vim.loader.enable() -- cache Lua modules; must come first

-- Core settings. keymaps sets <leader>, so it precedes all plugin configs.
require "user.options"
require "user.keymaps"
require "user.abbrev"
require "user.autocommands"

-- Plugin manager, then the colorscheme: UI plugins read highlights at setup.
require "user.plugins"
require "user.colorscheme"

-- project loads a telescope extension, so telescope comes first.
require "user.telescope"

-- Plugin configs
require "user.alpha"
require "user.autopairs"
require "user.bufferline"
require "user.cmp"
require "user.comment"
require "user.gitsigns"
require "user.illuminate"
require "user.indentline"
require "user.lsp"
require "user.lualine"
require "user.no-neck-pain"
require "user.nvim-tree"
require "user.project"
require "user.treesitter"
require "user.whichkey"
