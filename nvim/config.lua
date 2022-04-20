
local opts = { noremap=true, silent=true }

local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', [[<cmd>lua vim.lsp.buf.declaration()<CR>]], opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', [[<cmd>lua require('telescope.builtin').lsp_definitions()<CR>]], opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', [[<cmd>lua require('telescope.builtin').lsp_implementations()<CR>]], opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', [[<cmd>lua require('telescope.builtin').lsp_references()<CR>]], opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'e', '<cmd>lua vim.diagnostic.open_float(nil, { focusable = false })<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

    require "lsp_signature".on_attach()

    if client.resolved_capabilities.document_highlight then
      vim.cmd [[
        augroup lsp_document_highlight
          autocmd! * <buffer>
          autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
          autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
      ]]
    end

    if client.resolved_capabilities.document_formatting then
      vim.cmd [[
        augroup Format
          autocmd! * <buffer>
          autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync({},1500)
        augroup END
      ]]
    end

    vim.cmd('sign place 25252 line=30000 name=dummy buffer=' .. bufnr)

end

local semantic_token_handlers = {
    ['workspace/semanticTokens/refresh'] = function(err,  params, ctx, config)
        vim.lsp.buf_request(0, 'textDocument/semanticTokens/full',
          { textDocument = vim.lsp.util.make_text_document_params() }, nil)
      return vim.NIL
    end,
    ['textDocument/semanticTokens/full'] = function(err,  result, ctx, config)
      if not result then
        return
      end
      -- temporary handler until native support lands
      local bufnr = ctx.bufnr
      local client = vim.lsp.get_client_by_id(ctx.client_id)
      local legend = client.server_capabilities.semanticTokensProvider.legend
      local token_types = legend.tokenTypes
      local data = result.data

      local ns = vim.api.nvim_create_namespace('nvim-lsp-semantic')
      vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
      local prev_line, prev_start = nil, 0
      for i = 1, #data, 5 do
        local delta_line = data[i]
        prev_line = prev_line and prev_line + delta_line or delta_line
        local delta_start = data[i + 1]
        prev_start = delta_line == 0 and prev_start + delta_start or delta_start
        local token_type = token_types[data[i + 3] + 1]
        local line = vim.api.nvim_buf_get_lines(bufnr, prev_line, prev_line + 1, false)[1]
        local byte_start = vim.str_byteindex(line, prev_start)
        local byte_end = vim.str_byteindex(line, prev_start + data[i + 2])
        vim.api.nvim_buf_add_highlight(bufnr, ns, 'LspSemantic_' .. token_type, prev_line, byte_start, byte_end)
        -- require('vim.lsp.log').debug(bufnr, ns, 'LspSemantic_' .. token_type, prev_line, byte_start, byte_end)
      end
    end
  }

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities['workspace']['semanticTokens'] = {refreshSupport = true}

require'lspconfig'.pyright.setup{
    capabilities = capabilities,
    on_attach = on_attach,
}

require'lspconfig'.clangd.setup{
    capabilities = capabilities,
    on_attach = on_attach,
    handlers = semantic_token_handlers,
}

require'lspconfig'.rust_analyzer.setup({
    capabilities = capabilities,
    -- on_attach is a callback called when the language server attachs to the buffer
    on_attach = on_attach,
    handlers = semantic_token_handlers,
    settings = {
        -- to enable rust-analyzer settings visit:
        -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
        ["rust-analyzer"] = {
            -- enable clippy on save
            checkOnSave = {
                command = "clippy"
            },
        }
    },

})


-- vim.lsp.set_log_level("DEBUG")

local cmp =require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  -- Installed sources
  sources = {
    { name = 'path' },
    { name = 'buffer' },
    { name = 'nvim_lsp' },
  },
})

require("telescope").setup({
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      }
    }
  }
})

require("telescope").load_extension("ui-select")

vim.diagnostic.config({
    virtual_text = {
        severity = vim.diagnostic.severity.WARNING,
        source = "if_many",
    },
    float = {
        source = "if_many",
        border = "rounded",
    },
    severity_sort = true,
})


vim.cmd [[sign define dummy text=\ ]]

vim.cmd [[highlight link LspSemantic_attribute Define]]
vim.cmd [[highlight link LspSemantic_enum Type]]
vim.cmd [[highlight link LspSemantic_function Function]]
vim.cmd [[highlight link LspSemantic_derive Define]]
vim.cmd [[highlight link LspSemantic_macro PreProc]]
vim.cmd [[highlight link LspSemantic_method Function]]
vim.cmd [[highlight link LspSemantic_namespace Type]]
vim.cmd [[highlight link LspSemantic_struct Type]]
vim.cmd [[highlight link LspSemantic_trait TraitType]]
vim.cmd [[highlight link LspSemantic_interface TraitType]]
vim.cmd [[highlight link LspSemantic_typeAlias Type]]
vim.cmd [[highlight link LspSemantic_union Type]]

vim.cmd [[highlight link LspSemantic_boolean Boolean]]
vim.cmd [[highlight link LspSemantic_character Character]]
vim.cmd [[highlight link LspSemantic_number Number]]
vim.cmd [[highlight link LspSemantic_string String]]
vim.cmd [[highlight link LspSemantic_escapeSequence Special]]
vim.cmd [[highlight link LspSemantic_formatSpecifier Operator]]

vim.cmd [[highlight link LspSemantic_operator Operator]]
vim.cmd [[highlight link LspSemantic_arithmetic Operator]]
vim.cmd [[highlight link LspSemantic_bitwise Operator]]
vim.cmd [[highlight link LspSemantic_comparison Operator]]
vim.cmd [[highlight link LspSemantic_logical Operator]]

vim.cmd [[highlight link LspSemantic_punctuation Operator]]
vim.cmd [[highlight link LspSemantic_attributeBracket Operator]]
vim.cmd [[highlight link LspSemantic_angle Operator]]
vim.cmd [[highlight link LspSemantic_brace Operator]]
vim.cmd [[highlight link LspSemantic_bracket Operator]]
vim.cmd [[highlight link LspSemantic_parenthesis Operator]]
vim.cmd [[highlight link LspSemantic_colon Operator]]
vim.cmd [[highlight link LspSemantic_comma Operator]]
vim.cmd [[highlight link LspSemantic_dot Operator]]
vim.cmd [[highlight link LspSemantic_semi Operator]]
vim.cmd [[highlight link LspSemantic_macroBang PreProc]]

vim.cmd [[highlight link LspSemantic_builtinAttribute Define]]
vim.cmd [[highlight link LspSemantic_builtinType Type]]
vim.cmd [[highlight link LspSemantic_comment Comment]]
vim.cmd [[highlight link LspSemantic_constParameter Parameter]]
vim.cmd [[highlight link LspSemantic_enumMember Constant]]
-- vim.cmd [[highlight link LspSemantic_generic Variable]]
vim.cmd [[highlight link LspSemantic_keyword Keyword]]
vim.cmd [[highlight link LspSemantic_label Label]]
vim.cmd [[highlight link LspSemantic_lifetime Noise]]
vim.cmd [[highlight link LspSemantic_parameter Parameter]]
vim.cmd [[highlight link LspSemantic_property Property]]
vim.cmd [[highlight link LspSemantic_selfKeyword Special]]
-- vim.cmd [[highlight link LspSemantic_toolModule  ]]
vim.cmd [[highlight link LspSemantic_typeParameter TraitType]]
-- vim.cmd [[highlight link LspSemantic_unresolvedReference Unresolved]]
-- vim.cmd [[highlight link LspSemantic_variable Variable]]
--
vim.cmd [[hi LspReferenceText cterm=underline gui=underline]]
vim.cmd [[hi LspReferenceRead cterm=underline gui=underline]]
vim.cmd [[hi LspReferenceWrite cterm=underline gui=underline]]
