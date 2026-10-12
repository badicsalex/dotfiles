local cmp = require "cmp"

cmp.setup {
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end,
  },
  mapping = {
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-b>"] = cmp.mapping.scroll_docs(-1),
    ["<C-f>"] = cmp.mapping.scroll_docs(1),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm { select = false },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.snippet.active { direction = 1 } then
        vim.snippet.jump(1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.snippet.active { direction = -1 } then
        vim.snippet.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  formatting = {
    format = function(_, vim_item)
      local max_len = 40
      if vim_item.menu ~= nil and string.len(vim_item.menu) > max_len then
        vim_item.menu = string.sub(vim_item.menu, 1, max_len - 2) .. "…"
      end
      return vim_item
    end,
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
}

cmp.setup.filetype("book", { enabled = false })
