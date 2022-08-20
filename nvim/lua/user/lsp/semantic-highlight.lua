local M = {}

M.setup = function()
  local nvim_semantic_tokens = require "nvim-semantic-tokens"
  local semantic_tokens = require "nvim-semantic-tokens.semantic_tokens"
  nvim_semantic_tokens.setup({})
  vim.lsp.handlers["workspace/semanticTokens/refresh"] = vim.lsp.with(semantic_tokens.on_refresh, {})
  vim.lsp._request_name_to_capability["textDocument/semanticTokens/full"] = nil

  local table_highlighter = require "nvim-semantic-tokens.table-highlighter"
  table_highlighter.token_map = {
    attribute = "Define",
    enum = "Type",
    ["function"] = "Function",
    derive = "Define",
    macro = "PreProc",
    method = "Function",
    namespace = "Type",
    struct = "Type",
    trait = "TraitType",
    interface = "TraitType",
    typeAlias = "Type",
    union = "Type",

    boolean = "Boolean",
    character = "Character",
    number = "Number",
    string = "String",
    escapeSequence = "Special",
    formatSpecifier = "Operator",

    operator = "Operator",
    arithmetic = "Operator",
    bitwise = "Operator",
    comparison = "Operator",
    logical = "Operator",

    punctuation = "Operator",
    attributeBracket = "Operator",
    angle = "Operator",
    brace = "Operator",
    bracket = "Operator",
    parenthesis = "Operator",
    colon = "Operator",
    comma = "Operator",
    dot = "Operator",
    semi = "Operator",
    macroBang = "PreProc",

    builtinAttribute = "Define",
    builtinType = "Type",
    comment = "Comment",
    constParameter = "Parameter",
    enumMember = "Constant",
    -- generic = "--",
    keyword = "Keyword",
    label = "Label",
    lifetime = "Noise",
    parameter = "Parameter",
    property = "Property",
    selfKeyword = "Special",
    -- toolModule = "--",
    typeParameter = "TraitType",
    -- unresolvedReference = "--",
    -- variable = "--",
  }

  table_highlighter.reset()
  -- vim.lsp.set_log_level("DEBUG")
end

return M
