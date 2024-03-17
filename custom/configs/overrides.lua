local M = {}

M.copilot = {
	-- Possible configurable fields can be found on:
	-- https://github.com/zbirenbaum/copilot.lua#setup-and-configuration
	suggestion = {
		auto_trigger = true,
		keymap = {
			jump_prev = "[[",
			jump_next = "]]",
			accept = "<Tab>",
			refresh = "gr",
			open = "<M-CR>",
      accept_selected = "<M-CR>",
		},
	},
}

return M
