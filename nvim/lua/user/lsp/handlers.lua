local M = {}

-- TODO: backfill this to template
M.setup = function()
  local config = {
    -- disable virtual text
    virtual_text = {
        severity = vim.diagnostic.severity.WARNING,
        source = "if_many",
    },
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "if_many",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })

  require("user.lsp.semantic-highlight").setup()
end

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.documentHighlight then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
  end
end

local function lsp_keymaps(bufnr)

  local wk_opts = {
    buffer = bufnr, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
  }

  local wk_mappings = {
    g = {
      D = { [[<cmd>lua vim.lsp.buf.declaration()<CR>]], "Go to declaration"},
      d = { [[<cmd>lua require('telescope.builtin').lsp_definitions()<CR>]], "Go to definition"},
      i = { [[<cmd>lua require('telescope.builtin').lsp_implementations()<CR>]], "Go to implementation"},
      r = { [[<cmd>lua require('telescope.builtin').lsp_references()<CR>]], "Show References" },
      a = { '<cmd>lua vim.lsp.buf.code_action()<CR>', "Code action" },
      n = { '<cmd>lua vim.lsp.buf.rename()<CR>', "Rename"},
    },
    K = {'<cmd>lua vim.lsp.buf.hover()<CR>', "Hover"},
    e = {'<cmd>lua vim.diagnostic.open_float(nil, { focusable = false })<CR>', "Show errors"},
  }

  local which_key = require("which-key")
  which_key.setup(setup)
  which_key.register(wk_mappings, wk_opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format()' ]]
end

M.on_attach = function(client, bufnr)
  if client.name == "tsserver" then
    client.server_capabilities.formatting = false
  end
  lsp_keymaps(bufnr)
  lsp_highlight_document(client)
end

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  return
end

capabilities = require('cmp_nvim_lsp').default_capabilities()

if capabilities['workspace'] == nil then
    capabilities['workspace'] = {}
end

capabilities['workspace']['semanticTokens'] = {refreshSupport = true}

M.capabilities = capabilities
return M
