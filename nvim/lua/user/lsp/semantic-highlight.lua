local M = {}

M.setup = function()

  vim.lsp.handlers['workspace/semanticTokens/refresh'] = function(err,  params, ctx, config)
    vim.lsp.buf_request(
      0,
      'textDocument/semanticTokens/full',
      {
        textDocument = vim.lsp.util.make_text_document_params(),
        tick = vim.api.nvim_buf_get_changedtick(0)
      },
      nil
    )
    return vim.NIL
  end

  vim.lsp.handlers['textDocument/semanticTokens/full'] = function(err,  result, ctx, config)
    if err or not result or ctx.params.tick ~= vim.api.nvim_buf_get_changedtick(ctx.bufnr) then
      require('vim.lsp.log').debug("TICK NOT OK in textDocument/semanticTokens/full", ctx.params.tick, vim.api.nvim_buf_get_changedtick(ctx.bufnr) )
      return
    end
    require('vim.lsp.log').debug("Received semantic tokens.")
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

  vim.lsp.set_log_level("DEBUG")
end

return M
