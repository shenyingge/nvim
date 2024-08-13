require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- map("n", ";", ":", { desc = "CMD enter command mode" })

map("i", "jk", "<ESC>", { desc = "Escape insert mode" })

map({ "n", "i", "v" }, "<Left>", "<Nop>")
map({ "n", "i", "v" }, "<Right>", "<Nop>")
map({ "n", "i", "v" }, "<Up>", "<Nop>")
map({ "n", "i", "v" }, "<Down>", "<Nop>")

vim.opt.mouse = ""
