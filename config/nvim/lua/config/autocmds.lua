vim.api.nvim_create_autocmd({ "VimEnter", "BufReadPost" }, {
  pattern = "*.md",
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
    vim.opt.textwidth = 72
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

vim.api.nvim_create_autocmd("User", {
  desc = "Hide lualine on goyo enter",
  pattern = "GoyoEnter",
  callback = function()
    require("lualine").hide()
  end,
})

vim.api.nvim_create_autocmd("User", {
  desc = "Show lualine after goyo exit",
  pattern = "GoyoLeave",
  callback = function()
    require("lualine").hide({ unhide = true })
  end,
})
