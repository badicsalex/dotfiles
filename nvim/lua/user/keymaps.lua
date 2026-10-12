local opts = { silent = true }

vim.keymap.set("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<S-PageUp>", ":bnext<CR>", opts)
vim.keymap.set("n", "<S-PageDown>", ":bprevious<CR>", opts)
vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", opts)

vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

vim.keymap.del("n", "grn")
vim.keymap.del("n", "gra")
vim.keymap.del("n", "grr")
vim.keymap.del("n", "gri")
