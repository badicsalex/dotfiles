vim.loader.enable() -- cache Lua modules; must come first

-- Core settings. keymaps sets <leader>, so it precedes all plugin configs.
require "user.options"
require "user.keymaps"
require "user.abbrev"
require "user.autocommands"

-- Plugin manager, then the colorscheme: UI plugins read highlights at setup.
require "user.plugins"
require "user.colorscheme"

-- Plugin configs
require "user.alpha"
require "user.bufferline"
require "user.cmp"
require "user.gitsigns"
require "user.illuminate"
require "user.lsp"
require "user.lualine"
require "user.no-neck-pain"
require "user.nvim-tree"
require "user.telescope"
require "user.whichkey"
