local option = vim.opt
local buffer = vim.b
local global = vim.g
local opt = {noremap = true, silent = true }

-- Globol Settings --
option.showmode = false
option.backspace = { "indent", "eol", "start" }
option.tabstop = 4
option.shiftwidth = 4
option.expandtab = true
option.shiftround = true
option.autoindent = true
option.smartindent = true
option.number = true
option.relativenumber = true
option.wildmenu = true
option.hlsearch = false
option.ignorecase = true
option.smartcase = true
option.completeopt = { "menuone", "noselect" }
option.cursorline = true
option.termguicolors = true
option.signcolumn = "yes"
option.autoread = true
option.title = true
option.swapfile = false
option.backup = false
option.updatetime = 50
option.mouse = "a"
-- option.undofile = true
-- option.undodir = vim.fn.expand('$HOME/.local/share/nvim/undo')
option.exrc = true
option.wrap = false
option.splitright = true

-- Buffer Settings --
buffer.fileenconding = "utf-8"

-- Global Settings --
global.mapleader = " "
global.navic_silence = true

-- Key mappings --
vim.keymap.set({ "n", "i", "v" }, "<Left>", "<Nop>")
vim.keymap.set({ "n", "i", "v" }, "<Right>", "<Nop>")
vim.keymap.set({ "n", "i", "v" }, "<Up>", "<Nop>")
vim.keymap.set({ "n", "i", "v" }, "<Down>", "<Nop>")

vim.keymap.set("n", "<A-Tab>", "<cmd>bNext<CR>")
vim.keymap.set("n", "<leader>bd", "<cmd>bd!<CR>")
vim.keymap.set("n", "<leader>bn", "<cmd>bn<CR>")
vim.keymap.set("n", "<leader>bp", "<cmd>bp<CR>")

-- vim.keymap.set("t", "<leader>bd", "<cmd>bd<CR>!")

vim.keymap.set("n", "<leader>q", ":q<CR>")

vim.keymap.set("n", "<leader>wc", "<C-w>c")
vim.keymap.set("n", "<leader>wj", "<C-w>j")
vim.keymap.set("n", "<leader>wk", "<C-w>k")
vim.keymap.set("n", "<leader>wl", "<C-w>l")
vim.keymap.set("n", "<leader>wh", "<C-w>h")
vim.keymap.set("n", "<leader>ws", "<C-w>s")
vim.keymap.set("n", "<leader>wv", "<C-w>v")


vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set({ "v", "n" }, "<leader>y", "\"+y")

-- Terminal相关
vim.keymap.set("n", "<leader>t", ":terminal<CR>", opt) -- 在下边打开窗口
vim.keymap.set("n", "<leader>vt", ":vsp | terminal<CR>", opt) -- 在侧边打开窗口
vim.keymap.set("n", "<leader>st", ":belowright split | terminal<CR>")

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", opt)  -- 退出
vim.keymap.set("t", "<A-h>", [[ <C-\><C-N><C-w>h ]], opt)
vim.keymap.set("t", "<A-j>", [[ <C-\><C-N><C-w>j ]], opt)
vim.keymap.set("t", "<A-k>", [[ <C-\><C-N><C-w>k ]], opt)
vim.keymap.set("t", "<A-l>", [[ <C-\><C-N><C-w>l ]], opt)
