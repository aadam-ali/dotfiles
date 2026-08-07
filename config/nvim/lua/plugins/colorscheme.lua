return {
  "sainnhe/gruvbox-material",
  config = function()
    vim.g.gruvbox_material_enable_italic = true
    vim.g.gruvbox_material_foreground = "original"
    vim.g.gruvbox_material_background = "hard"
    vim.opt.background = "dark"
    vim.cmd("colorscheme gruvbox-material")
  end,
}
