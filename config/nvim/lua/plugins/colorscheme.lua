return {
  "sainnhe/gruvbox-material",
  config = function()
    vim.g.gruvbox_material_enable_italic = true
    vim.opt.background = "dark"
    vim.cmd("colorscheme gruvbox-material")
  end,
}
