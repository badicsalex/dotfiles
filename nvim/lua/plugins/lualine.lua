local diagnostics = {
	"diagnostics",
	sections = { "error", "warn" },
	symbols = { error = "E: ", warn = "W: " },
}

local filetype = {
	"filetype",
	icons_enabled = false,
}

local lsp_progress = {}

vim.api.nvim_create_autocmd("LspProgress", {
	callback = function(ev)
		local tokens = lsp_progress[ev.data.client_id] or {}
		lsp_progress[ev.data.client_id] = tokens
		local value = ev.data.params.value
		if value.kind == "end" then
			tokens[ev.data.params.token] = nil
		else
			local text = value.title or ""
			if value.message then
				text = text .. " " .. value.message
			end
			tokens[ev.data.params.token] = text
		end
		require("lualine").refresh()
	end,
})

-- A client stopped mid-task never sends the "end" message.
vim.api.nvim_create_autocmd("LspDetach", {
	callback = function(ev)
		lsp_progress[ev.data.client_id] = nil
	end,
})

local function lsp_progress_text()
	local texts = {}
	for _, tokens in pairs(lsp_progress) do
		vim.list_extend(texts, vim.tbl_values(tokens))
	end
	-- Function components aren't escaped, and the statusline reads % as an item.
	return (table.concat(texts, ", "):gsub("%%", "%%%%"))
end

require("lualine").setup({
	options = {
		theme = "tokyonight",
		disabled_filetypes = { "alpha", "NvimTree" },
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_b = { 'branch' },
		lualine_c = { 'filename', lsp_progress_text },
		lualine_x = { 'diff', diagnostics, 'encoding', filetype },
		lualine_y = { 'progress' },
		lualine_z = { 'location' },
	},
})
