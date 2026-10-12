local telescope = require "telescope"
local actions = require "telescope.actions"

telescope.setup {
  defaults = {
    path_display = { "smart" },
    mappings = {
      i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
    },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {},
    },
  },
}

telescope.load_extension "ui-select"
