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

nvim_tree.setup {
  disable_netrw = true,
  open_on_setup = true,
  open_on_setup_file = true,
  ignore_buffer_on_setup = true,
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
    mappings = {
      list = {
        { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
        { key = "h", cb = tree_cb "close_node" },
        { key = "v", cb = tree_cb "vsplit" },
      },
    },
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
