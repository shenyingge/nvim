vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "
vim.opt.relativenumber = true
-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"


if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    config = function()
      require "options"
    end,
  },
 { import = "custom.plugins" },
}, lazy_config)

-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = false,                    -- false will only do exact matching
      override_generic_sorter = false,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')

if vim.g.vscode then
  require('vscode-multi-cursor').setup { -- Config is optional
    -- Whether to set default mappings
    default_mappings = true,
    -- If set to true, only multiple cursors will be created without multiple selections
    no_selection = false
  }

  local cursors = require('vscode-multi-cursor')

  local k = vim.keymap.set
  k({ 'n', 'x' }, 'mc', cursors.create_cursor, { expr = true, desc = 'Create cursor' })
  k({ 'n' }, 'mcc', cursors.cancel, { desc = 'Cancel/Clear all cursors' })
  k({ 'n', 'x' }, 'mi', cursors.start_left, { desc = 'Start cursors on the left' })
  k({ 'n', 'x' }, 'mI', cursors.start_left_edge, { desc = 'Start cursors on the left edge' })
  k({ 'n', 'x' }, 'ma', cursors.start_right, { desc = 'Start cursors on the right' })
  k({ 'n', 'x' }, 'mA', cursors.start_right, { desc = 'Start cursors on the right' })
  k({ 'n' }, '[mc', cursors.prev_cursor, { desc = 'Goto prev cursor' })
  k({ 'n' }, ']mc', cursors.next_cursor, { desc = 'Goto next cursor' })
  k({ 'n' }, 'mcs', cursors.flash_char, { desc = 'Create cursor using flash' })
  k({ 'n' }, 'mcw', cursors.flash_word, { desc = 'Create selection using flash' })
end
-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "nvchad.autocmds"

vim.schedule(function()
 require "mappings"
end)

vim.opt.undofile = false
vim.api.nvim_set_keymap('n', '<C-j>', '10j', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-k>', '10k', {noremap = true, silent = true})


vim.api.nvim_set_keymap('n', '<C-j>', '10j', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-k>', '10k', {noremap = true, silent = true})


local parser_config = require "nvim-treesitter.parsers".get_parser_configs()

parser_config.your_language = {
  -- 要禁用高亮的语言，替换 `your_language` 为目标语言，例如 'python' 或 'lua'
  highlight = {
    -- 这里通过修改 highlight 模块，覆盖默认高亮规则
    injections = {
      -- 禁用特定单词的高亮
      ["gold"] = false,
      ["silver"] = false,
    },
  },
}

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,              -- 启用高亮
    additional_vim_regex_highlighting = false,},
}


require("toggleterm").setup({
    open_mapping = [[<c-\>]],
    -- 打开新终端后自动进入插入模式
    start_in_insert = true,
    -- 在当前buffer的下方打开新终端
    direction = 'horizontal'
})
vim.keymap.set("t", "<Esc>", "<C-\\><C-N>")
-- vim.keymap.set("t", "jk", [[<C-\><C-n>]], {noremap = true, silent = true})
-- vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-W>h]], {noremap = true, silent = true})
-- vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-W>j]], {noremap = true, silent = true})
-- vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-W>k]], {noremap = true, silent = true})
-- vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-W>l]], {noremap = true, silent = true})
--
-- Auto-format Python files on save
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*.py",
--   callback = function()
--     -- Format with black and trim whitespace
--     vim.lsp.buf.format({ async = false })
--   end,
-- })


-- Trim space
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.py",
  callback = function()
    -- Save the current cursor position
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    -- Execute the command to trim trailing whitespace
    vim.cmd([[%s/\s\+$//e]])
    -- Restore the cursor position
    vim.api.nvim_win_set_cursor(0, cursor_pos)
  end,
})
-- Ensure a newline at EOF
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.py",
  callback = function()
    local last_line = vim.fn.line('$')
    local last_line_content = vim.fn.getline(last_line)
    if last_line_content ~= "" then
      vim.cmd("normal! Go")  -- Go to last line and insert a newline
    end
  end,
})

vim.opt.termguicolors = true

vim.api.nvim_set_keymap('n', '<Leader>q', ':qa<CR>', {noremap = true, silent = true, desc = "quit all windows"})
