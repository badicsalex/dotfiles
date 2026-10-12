require("bufferline").setup {
  options = {
    close_command = "Bdelete! %d",
    middle_mouse_command = "Bdelete! %d",
    offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
  }
}
