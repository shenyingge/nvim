local overrides = require("custom.configs.overrides")
_opts = function(description)
	return { noremap = true, silent = true, desc = description }
end

return {
	{
		"stevearc/conform.nvim",
		config = function()
			require("configs.conform")
		end,
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
    -- stylua: ignore
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
	},
	{
		"nvim-tree/nvim-tree.lua",
		opts = {
			git = { enable = true },
		},
		cond = not vim.g.vscode,
	},
	{
		"neovim/nvim-lspconfig",
		cond = not vim.g.vscode,
		config = function()
			require("nvchad.configs.lspconfig").defaults()
			require("configs.lspconfig")
		end,
	},
	{
		"williamboman/mason.nvim",
		cond = not vim.g.vscode,
		opts = {
			ensure_installed = {
				"debugpy",
				"black",
				"lua-language-server",
				"html-lsp",
				"prettier",
				"stylua",
				"mypy",
				"ruff",
				"pyright",
			},
		},
	},
	{ "RRethy/vim-illuminate", event = "VimEnter" },
	{
		"kylechui/nvim-surround",
		lazy = true,
		keys = { "cs", "ds", "ys" },
		config = function()
			require("nvim-surround").setup()
		end,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	},
	{
		"vscode-neovim/vscode-multi-cursor.nvim",
		event = "VeryLazy",
		cond = not not vim.g.vscode,
		opts = {},
	},
	{ "akinsho/toggleterm.nvim", version = "*", opts = {} },
	{
		"jose-elias-alvarez/null-ls.nvim",
		ft = { "python" },
		opts = function()
			return require("custom.configs.null-ls")
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		build = ":Copilot auth",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				panel = {
					enabled = true,
					auto_refresh = false,
					keymap = {
						jump_prev = "[[",
						jump_next = "]]",
						accept = "<CR>",
						refresh = "gr",
						open = "<M-CR>",
					},
					layout = {
						position = "bottom", -- | top | left | right
						ratio = 0.4,
					},
				},
				suggestion = {
					enabled = true,
					auto_trigger = true,
					hide_during_completion = true,
					debounce = 75,
					keymap = {
						accept = "<M-l>",
						accept_word = false,
						accept_line = false,
						next = "<M-]>",
						prev = "<M-[>",
						dismiss = "<C-]>",
					},
				},
				filetypes = {
					yaml = false,
					markdown = false,
					help = false,
					gitcommit = false,
					gitrebase = false,
					hgcommit = false,
					svn = false,
					cvs = false,
					["."] = false,
				},
				copilot_node_command = "node", -- Node.js version must be > 18.x
				server_opts_overrides = {},
			})
		end,
	},
	{
		"theHamsta/nvim-dap-virtual-text",
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-telescope/telescope-dap.nvim",
		},
		config = function()
			-- require('dap.ext.vscode').json_decode = vim.json.decode
			require("dap.ext.vscode").load_launchjs()
			-- require('dap.ext.vscode').json_decode = require'json5'.parse
			require("nvim-dap-virtual-text").setup()
			vim.keymap.set("n", "<F5>", function()
				require("telescope").extensions.dap.configurations({})
			end, _opts("Load DAP Configurations"))
			vim.keymap.set("n", "<Leader>da", function()
				require("dap").continue()
			end, _opts("DAP Continue"))
			vim.keymap.set("n", "<F10>", function()
				require("dap").step_over()
			end, _opts("DAP Step Over"))
			vim.keymap.set("n", "<F11>", function()
				require("dap").step_into()
			end, _opts("DAP Step Into"))
			vim.keymap.set("n", "<F12>", function()
				require("dap").step_out()
			end, _opts("DAP Step Out"))
			vim.keymap.set("n", "<Leader>db", function()
				require("dap").toggle_breakpoint()
			end, _opts("Toggle DAP Breakpoint"))
			-- vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end, _opts("Set DAP Breakpoint"))
			vim.keymap.set("n", "<Leader>lp", function()
				require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
			end, _opts("Set DAP Logpoint"))
			vim.keymap.set("n", "<Leader>dr", function()
				require("dap").repl.open()
			end, _opts("Open DAP REPL"))
			vim.keymap.set("n", "<Leader>dl", function()
				require("dap").run_last()
			end, _opts("Run Last DAP"))
			vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
				require("dap.ui.widgets").hover()
			end, _opts("DAP Hover"))
			vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
				require("dap.ui.widgets").preview()
			end, _opts("DAP Preview"))
			vim.keymap.set("n", "<Leader>df", function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.frames)
			end, _opts("DAP Frames"))
			vim.keymap.set("n", "<Leader>ds", function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.scopes)
			end, _opts("DAP Scopes"))
		end,
	},
	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
    -- stylua: ignore
    config = function()
      require 'nvim-treesitter.configs'.setup {
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        ensure_installed = "python", -- 确保自动安装 Python 解析器
      }
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
      require('custom.configs.pydap')
    end
,
	},
	{
		"rcarriga/nvim-dap-ui",
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup()

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end

			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end

			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},
	{ "nvim-neotest/nvim-nio" },
	{
		"romgrk/nvim-treesitter-context",
		lazy = true,
		event = { "User FileOpened" },
		config = function()
			require("treesitter-context").setup({
				enable = true,
				throttle = true,
				max_lines = 0,
				patterns = {
					default = {
						"class",
						"function",
						"method",
					},
				},
			})
		end,
	},
	{
		"rmagatti/goto-preview",
		event = "BufEnter",
		config = function()
			require("goto-preview").setup({
				width = 120, -- Width of the floating window
				height = 15, -- Height of the floating window
				default_mappings = true, -- Bind default mappings
				debug = false, -- Print debug information
				opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
				post_open_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
			})
			local opts = function(description)
				return { noremap = true, silent = true, desc = description }
			end

			vim.keymap.set("n", "gpd", function()
				require("goto-preview").goto_preview_definition()
			end, opts("Preview definition"))

			vim.keymap.set("n", "gpt", function()
				require("goto-preview").goto_preview_type_definition()
			end, opts("Preview type definition"))

			vim.keymap.set("n", "gpi", function()
				require("goto-preview").goto_preview_implementation()
			end, opts("Preview implementation"))

			vim.keymap.set("n", "gpD", function()
				require("goto-preview").goto_preview_declaration()
			end, opts("Preview declaration"))

			vim.keymap.set("n", "gP", function()
				require("goto-preview").close_all_win()
			end, opts("Close all preview windows"))

			vim.keymap.set("n", "gpr", function()
				require("goto-preview").goto_preview_references()
			end, opts("Preview references"))
		end,
	},
	{ "nvim-lua/plenary.nvim" },
	{
		"folke/todo-comments.nvim",
		lazy = true,
		event = { "BufEnter" },
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("todo-comments").setup()
		end,
	},
	{
		"windwp/nvim-spectre",
		lazy = true,
		cmd = { "Spectre" },
		config = function()
			require("spectre").setup({
				replace_engine = {
					["sed"] = {
						cmd = "sed",
						args = {
							"-i",
							"",
							"-E",
						},
					},
				},
			})
			local opts = function(description)
				return { noremap = true, silent = true, desc = description }
			end

			-- 定义正常模式和可视模式的键映射
			local keymap = {
				["oss"] = {
					function()
						require("spectre").open()
					end,
					"Spectre Open",
				},

				["osw"] = {
					function()
						require("spectre").open_visual({ select_word = true })
					end,
					"Spectre in Visual Word",
				},

				["osf"] = {
					function()
						vim.cmd("normal! viw")
						require("spectre").open_file_search()
					end,
					"Spectre in File",
				},
			}

			local vkeymap = {
				["osw"] = {
					function()
						require("spectre").open_visual()
					end,
					"Spectre in Visual",
				},
			}

			-- 应用正常模式的键映射
			for k, v in pairs(keymap) do
				vim.keymap.set("n", k, v[1], opts(v[2]))
			end

			-- 应用可视模式的键映射
			for k, v in pairs(vkeymap) do
				vim.keymap.set("v", k, v[1], opts(v[2]))
			end
		end,
	},
	{
		"zbirenbaum/neodim",
		lazy = true,
		event = "LspAttach",
		config = function()
			require("neodim").setup({
				alpha = 0.75,
				blend_color = "#000000",
				update_in_insert = {
					enable = true,
					delay = 100,
				},
				hide = {
					virtual_text = true,
					signs = false,
					underline = false,
				},
			})
		end,
	},
	{
		"rcarriga/nvim-notify",
		lazy = true,
		event = "VeryLazy",
		config = function()
			local notify = require("notify")
			notify.setup({
				-- "fade", "slide", "fade_in_slide_out", "static"
				stages = "static",
				on_open = nil,
				on_close = nil,
				timeout = 3000,
				fps = 1,
				render = "default",
				background_colour = "Normal",
				max_width = math.floor(vim.api.nvim_win_get_width(0) / 2),
				max_height = math.floor(vim.api.nvim_win_get_height(0) / 4),
				-- minimum_width = 50,
				-- ERROR > WARN > INFO > DEBUG > TRACE
				level = "TRACE",
			})

			vim.notify = notify
		end,
	},
	{
		"s1n7ax/nvim-window-picker",
		lazy = true,
		event = { "WinNew" },
		config = function()
			local picker = require("window-picker")
			picker.setup({
				autoselect_one = true,
				include_current = false,
				filter_rules = {
					bo = {
						filetype = { "neo-tree", "neo-tree-popup", "notify", "quickfix" },
						buftype = { "terminal" },
					},
				},
				other_win_hl_color = "#e35e4f",
			})

			vim.keymap.set("n", ",w", function()
				local picked_window_id = picker.pick_window({
					include_current_win = true,
				}) or vim.api.nvim_get_current_win()
				vim.api.nvim_set_current_win(picked_window_id)
			end, { desc = "Pick a window" })

			-- Swap two windows using the awesome window picker
			local function swap_windows()
				local window = picker.pick_window({
					include_current_win = false,
				})
				local target_buffer = vim.fn.winbufnr(window)
				-- Set the target window to contain current buffer
				vim.api.nvim_win_set_buf(window, 0)
				-- Set current window to contain target buffer
				vim.api.nvim_win_set_buf(0, target_buffer)
			end

			vim.keymap.set("n", ",W", swap_windows, { desc = "Swap windows" })
		end,
	},
	{
		"nvim-zh/colorful-winsep.nvim",
		config = true,
		event = { "WinLeave" },
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		lazy = true,
		event = { "User FileOpened" },
		after = "nvim-treesitter",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("nvim-treesitter.configs").setup({
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
							["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
							["id"] = "@conditional.inner",
							["ad"] = "@conditional.outer",
						},
						selection_modes = {
							["@parameter.outer"] = "v", -- charwise
							["@function.outer"] = "V", -- linewise
							["@class.outer"] = "<c-v>", -- blockwise
						},
						include_surrounding_whitespace = false,
					},
					move = {
						enable = true,
						set_jumps = true,
						goto_next_start = {
							["]m"] = "@function.outer",
							["]]"] = { query = "@class.outer", desc = "Next class start" },
							--
							-- You can use regex matching and/or pass a list in a "query" key to group multiple queires.
							["]o"] = "@loop.*",
							-- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
							--
							-- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
							-- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
							["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
							["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
						},
						goto_next_end = {
							["]M"] = "@function.outer",
							["]["] = "@class.outer",
						},
						goto_previous_start = {
							["[m"] = "@function.outer",
							["[["] = "@class.outer",
						},
						goto_previous_end = {
							["[M"] = "@function.outer",
							["[]"] = "@class.outer",
						},
						-- Below will go to either the start or the end, whichever is closer.
						-- Use if you want more granular movements
						-- Make it even more gradual by adding multiple queries and regex.
						goto_next = {
							["]d"] = "@conditional.outer",
						},
						goto_previous = {
							["[d"] = "@conditional.outer",
						},
					},
					swap = {
						enable = false,
						swap_next = {
							["<leader>a"] = "@parameter.inner",
						},
						swap_previous = {
							["<leader>A"] = "@parameter.inner",
						},
					},
				},
			})
			local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

			-- Repeat movement with ; and ,
			-- ensure ; goes forward and , goes backward regardless of the last direction
			vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
			vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

			-- vim way: ; goes to the direction you were moving.
			-- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
			-- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

			-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
			-- vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
			-- vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
			-- vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
			-- vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
		end,
	},
	{
		"karb94/neoscroll.nvim",
		lazy = true,
		-- event = "WinScrolled",
		keys = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
		config = function()
			require("neoscroll").setup({
				-- All these keys will be mapped to their corresponding default scrolling animation
				-- mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
				hide_cursor = true,
				stop_eof = true,
				use_local_scrolloff = false,
				respect_scrolloff = false,
				cursor_scrolls_alone = true,
				-- quadratic, cubic, quartic, quintic, circular, sine
				easing_function = "cubic",
				pre_hook = nil,
				post_hook = nil,
			})

			local t = {}
			t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "50", [['cubic']] } }
			t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "50", [['cubic']] } }
			t["<C-b>"] = { "scroll", { "-vim.api.nvim_win_get_height(0)", "true", "50", [['cubic']] } }
			t["<C-f>"] = { "scroll", { "vim.api.nvim_win_get_height(0)", "true", "50", [['cubic']] } }
			t["<C-y>"] = { "scroll", { "-0.10", "false", "50", [['cubic']] } }
			t["<C-e>"] = { "scroll", { "0.10", "false", "50", [['cubic']] } }
			t["zt"] = { "zt", { "100", [['cubic']] } }
			t["zz"] = { "zz", { "100", [['cubic']] } }
			t["zb"] = { "zb", { "100", [['cubic']] } }

			require("neoscroll.config").set_mappings(t)
		end,
	},
}
