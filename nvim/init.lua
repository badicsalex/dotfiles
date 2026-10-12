vim.loader.enable() -- cache Lua modules; must come first

-- Core settings. keymaps sets <leader>, so it precedes all plugin configs.
require "options"
require "keymaps"
require "abbrev"
require "autocommands"

require "plugins"
-- Takes its capabilities from cmp-nvim-lsp, so it comes after the plugins.
require "lsp"
