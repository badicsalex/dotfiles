local status_ok, nnp = pcall(require, "no-neck-pain")
if not status_ok then
  return
end

nnp.setup({
  buffers = {
    colors = { background = "tokyonight-night" },
  },
})
