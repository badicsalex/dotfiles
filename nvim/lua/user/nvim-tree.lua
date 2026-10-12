local function on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)

  vim.keymap.set('n', 'v', api.node.open.vertical, opts('Open: Vertical Split'))
end

require("nvim-tree").setup {
  on_attach = on_attach,
  disable_netrw = true,
  sync_root_with_cwd = true,
  diagnostics = {
    enable = true,
    show_on_dirs = true,
  },
  update_focused_file = {
    enable = true,
  },
  renderer = {
    indent_markers = { enable = true },
    icons = {
      git_placement = "after",
    },
  },
}

vim.api.nvim_create_autocmd({"QuitPre"}, {
    callback = function()
        local invalid_win = {}
        local wins = vim.api.nvim_list_wins()
        for _, w in ipairs(wins) do
          local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
          if bufname:match("NvimTree_") ~= nil then
            table.insert(invalid_win, w)
          end
        end
        if #invalid_win == #wins - 1 then
          for _, w in ipairs(invalid_win) do vim.api.nvim_win_close(w, true) end
        end
      end
})

local function open_nvim_tree()
    require("nvim-tree.api").tree.open({focus=false, find_file=true})
    local wins = vim.api.nvim_list_wins()
    for _, w in ipairs(wins) do
      local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
      if bufname:match("NvimTree_") == nil then
          vim.api.nvim_set_current_win(w)
          require('lualine').refresh()
          return
      end
    end
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
