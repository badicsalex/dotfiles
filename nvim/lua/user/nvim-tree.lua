-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
  return
end

local tree_cb = nvim_tree_config.nvim_tree_callback

local function on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)

  vim.keymap.set('n', 'v', api.node.open.vertical, opts('Open: Vertical Split'))
end

nvim_tree.setup {
  on_attach = on_attach,
  disable_netrw = true,
  update_cwd = true,
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = "ⓘ",
      info = "ⓘ",
      warning = "Ⓧ",
      error = "Ⓧ",
    },
  },
  update_focused_file = {
    enable = true,
  },
  view = {
    signcolumn = "yes",
  },
  renderer = {
    indent_markers = { enable = true },
    icons = {
      git_placement = "after",
      glyphs = {
        default = " ",
        symlink = "➜",
        git = {
          unstaged = "~",
          staged = "✓",
          unmerged = "?",
          renamed = "➜",
          deleted = "✗",
          untracked = "U",
          ignored = "",
        },
        folder = {
          default = "🗀",
          open = "🗁",
          empty = "🗀",
          empty_open = "🗁",
          symlink = "➜",
          arrow_open = "▾",
          arrow_closed = "▸",
        },
      } 
    },
  },
}

vim.cmd [[ autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() && len(filter(getbufinfo(), 'v:val.changed == 1')) == 0 | quit | endif ]]

local function open_nvim_tree()
  require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
