local M = {}
if vim.g.vscode then
  return M
end

M.ui = {
	------------------------------- base46 -------------------------------------
	-- hl = highlights
	hl_add = {},
	hl_override = {},
	changed_themes = {},
	theme_toggle = { "onedark", "one_light" },
	theme = "onedark", -- default theme
	transparency = false,

	cmp = {
		icons = true,
		lspkind_text = true,
		style = "default", -- default/flat_light/flat_dark/atom/atom_colored
	},

	telescope = { style = "borderless" }, -- borderless / bordered

	------------------------------- nvchad_ui modules -----------------------------
	statusline = {
	  theme = "default", -- default/vscode/vscode_colored/minimal
	  -- default/round/block/arrow separators work only for default statusline theme
	  -- round and block will work for minimal theme only
	  separator_style = "default",
	  order = nil,
	  modules = nil,
	  custom_sections = {
	    lualine_c = {
	      "filename",
	      "location"
	    },
	  }
	},
	-- lazyload it when there are 1+ buffers
	tabufline = {
		enabled = true,
		lazyload = true,
		order = { "treeOffset", "buffers", "tabs", "btns" },
		modules = nil,
	},

	nvdash = {
		load_on_startup = true,

		header = {
      "       .__                         .__                              " ,
      "  _____|  |__   ____   ____ ___.__.|__| ____    ____   ____   ____  " ,
      " /  ___/  |  \\_/ __ \\ /    <   |  ||  |/    \\  / ___\\ / ___\\_/ __ \\ " ,
      " \\___ \\|   Y  \\  ___/|   |  \\___  ||  |   |  \\/ /_/  > /_/  >  ___/ " ,
      "/____  >___|  /\\___  >___|  / ____||__|___|  /\\___  /\\___  / \\___  >" ,
      "     \\/     \\/     \\/     \\/\\/             \\//_____//_____/      \\/ "
		},

		buttons = {
			{ "  Find File", ", f f", "Telescope find_files" },
			{ "󰈚  Recent Files", ", f o", "Telescope oldfiles" },
			{ "󰈭  Find Word", ", f w", "Telescope live_grep" },
			{ "  Bookmarks", ", m a", "Telescope marks" },
			{ "  Themes", ", t h", "Telescope themes" },
			{ "  Mappings", ", c h", "NvCheatsheet" },
		},
	},

	cheatsheet = { theme = "grid" }, -- simple/grid

	lsp = {
		signature = true,
		semantic_tokens = false,
	},

	term = {
		-- hl = "Normal:term,WinSeparator:WinSeparator",
		sizes = { sp = 0.3, vsp = 0.2 },
		float = {
			relative = "editor",
			row = 0.3,
			col = 0.25,
			width = 0.5,
			height = 0.4,
			border = "single",
		},
	},
}

M.base46 = {
	integrations = {
		"blankline",
		"cmp",
		"defaults",
		"devicons",
		"git",
		"lsp",
		"mason",
		"nvcheatsheet",
		"nvdash",
		"nvimtree",
		-- "statusline",
		"syntax",
		-- "treesitter",
		"tbline",
		"telescope",
		"whichkey",
	},
}

return M
