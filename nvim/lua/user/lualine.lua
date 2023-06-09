local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	symbols = { error = "E: ", warn = "W: " },
	colored = true,
	update_in_insert = false,
	always_visible = false,
}

local filetype = {
	"filetype",
	icons_enabled = false,
	icon = nil,
}

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "tokyonight",
		disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
		always_divide_middle = true,
	},
	sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = { 'filename', 'lsp_progress' },
        lualine_x = { 'diff', diagnostics, 'encoding', filetype },
        lualine_y = { 'progress' },
        lualine_z = { 'location'  },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})
