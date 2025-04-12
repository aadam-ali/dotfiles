return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
    opts = {
      heading = {
        icons = { "§ ", "§§ ", "§§§ ", "§§§§ ", "§§§§§ ", "§§§§§§ " },
        signs = { "" },
        backgrounds = {
          "default",
          "default",
          "default",
          "default",
          "default",
          "default",
        },
      },
    },
  },
  {
    "folke/zen-mode.nvim",
    opts = {
      window = {
        width = 80,
      },
    },
  },
}
