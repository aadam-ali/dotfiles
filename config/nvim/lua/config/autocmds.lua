-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- https://github.com/folke/zen-mode.nvim/issues/51#issuecomment-2030028351
vim.cmd("autocmd VimEnter *.md :ZenMode")

vim.api.nvim_create_autocmd({ "VimEnter", "BufReadPost" }, {
  pattern = "*.md",
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
    vim.opt.textwidth = 72

    require("zen-mode").open()
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.keymap.set("n", "<space>zo", ":SBOpenNote<CR>", { desc = "Open Note From Link" })
    vim.keymap.set("n", "<space>zl", ":SBLinkNote<CR>", { desc = "Insert Link to Note" })
  end,
})
