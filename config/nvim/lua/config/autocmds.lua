-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Load markdown specific settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    require("cmp").setup({ enabled = false }) -- disable completion

    vim.keymap.set("n", "<space>zo", ":SBOpenNote<CR>", { desc = "Open note from link" })
    vim.keymap.set("n", "<space>zl", ":SBLinkNote<CR>", { desc = "Add link to note" })
    vim.keymap.set("n", "<space>zm", ":ZenMode<CR>", { desc = "Enable zen mode" })
  end,
})

vim.api.nvim_create_autocmd("filetype", {
  pattern = { "go" },
  command = 'lua require("cmp").setup { enabled = true }',
})
