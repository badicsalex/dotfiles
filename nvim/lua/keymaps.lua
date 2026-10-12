local opts = { silent = true }

vim.keymap.set("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<S-PageUp>", ":bnext<CR>", opts)
vim.keymap.set("n", "<S-PageDown>", ":bprevious<CR>", opts)
vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", opts)

vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Our gr (references) would wait for a second key while any default gr* map exists.
for _, map in ipairs(vim.api.nvim_get_keymap "n") do
  if map.lhs:match "^gr." then
    vim.keymap.del("n", map.lhs)
  end
end
