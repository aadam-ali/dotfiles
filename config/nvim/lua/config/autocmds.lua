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

-- Open Neotree when no file provided
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 then
      require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
    end
  end,
})
