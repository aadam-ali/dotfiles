return {
  "EdenEast/nightfox.nvim",
  config = function()
    require("nightfox").setup({
      options = {
        styles = {
          comments = "italic", -- Optional
          keywords = "bold", -- ✅ Bold keywords
          types = "italic,bold", -- Optional
        },
      },
    })

    vim.opt.background = "dark"
    vim.cmd("colorscheme carbonfox")
  end,
}
