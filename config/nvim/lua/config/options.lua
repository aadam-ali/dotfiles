-- Map leader key to space
vim.g.mapleader = " "

-- Enables relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Allow undoing after closing and reopening file
vim.opt.undofile = true

-- Convert tabs to spaces
vim.opt.expandtab = true

-- Auto indent base on previous lines, and indent based on syntax
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Set indentation two 2 characters
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2

-- Show whitespace
-- vim.opt.list = true
vim.opt.listchars:append("space:·")

-- Enable search highlighting
vim.opt.hlsearch = true

-- Use system clipboard
vim.opt.clipboard = "unnamedplus"

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
