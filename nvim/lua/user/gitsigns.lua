require("gitsigns").setup {
  signs = {
    add = { text = "▎" },
    untracked = { text = "▎" },
    change = { text = "▎" },
    changedelete = { text = "▎" },
  },
  attach_to_untracked = true,
  preview_config = {
    border = "rounded",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
}
