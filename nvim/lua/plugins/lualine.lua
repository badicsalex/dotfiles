local diagnostics = {
	"diagnostics",
	sections = { "error", "warn" },
	symbols = { error = "E: ", warn = "W: " },
}

local filetype = {
	"filetype",
	icons_enabled = false,
}

require("lualine").setup({
	options = {
		theme = "tokyonight",
		disabled_filetypes = { "alpha", "NvimTree" },
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_b = { 'branch' },
		lualine_c = { 'filename', 'lsp_status' },
		lualine_x = { 'diff', diagnostics, 'encoding', filetype },
		lualine_y = { 'progress' },
		lualine_z = { 'location' },
	},
})
