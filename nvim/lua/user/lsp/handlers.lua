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
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "",
        [vim.diagnostic.severity.WARN] = "",
        [vim.diagnostic.severity.INFO] = "󰋼",
        [vim.diagnostic.severity.HINT] = "󰋼",
      },
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })

  vim.lsp.handlers["wgsl-analyzer/requestConfiguration"] = function(err, result, ctx, config)
    return {
        success = true,
        customImports = { _dummy_ = "dummy"},
        shaderDefs = {},
        trace = {
            extension = false,
            server = false,
        },
        inlayHints = {
            enabled = false,
            typeHints = false,
            parameterHints = false,
            structLayoutHints = false,
            typeVerbosity = "inner",
        },
        diagnostics = {
            typeErrors = true,
            nagaParsingErrors = true,
            nagaValidationErrors = true,
            nagaVersion = "main",
        }
    }
  end
end

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
    local status_ok, illuminate = pcall(require, "illuminate")
    if not status_ok then
      return
    end
    illuminate.on_attach(client)
  -- end
end

M.on_attach = function(client, bufnr)
  if client.name == "tsserver" then
    client.server_capabilities.formatting = false
  end
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format()' ]]
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
