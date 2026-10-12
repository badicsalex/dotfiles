vim.diagnostic.config {
  virtual_text = { source = "if_many" },
  severity_sort = true,
  float = {
    focusable = false,
    border = "rounded",
    source = "if_many",
    header = "",
    prefix = "",
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "󰋼",
      [vim.diagnostic.severity.HINT] = "󰋼",
    },
  },
  jump = {
    on_jump = function(_, bufnr)
      vim.diagnostic.open_float { bufnr = bufnr, scope = "cursor", focus = false }
    end,
  },
}

vim.lsp.config("*", { capabilities = require("cmp_nvim_lsp").default_capabilities() })
vim.lsp.enable { "clangd", "rust_analyzer", "html" }
