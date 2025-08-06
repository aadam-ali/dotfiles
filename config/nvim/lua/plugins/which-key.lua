return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts_extend = { "spec" },
  opts = {
    delay = 200,
    preset = "helix",
    spec = {
      { "<leader>b", group = "Buffers" },
      { "<leader>c", group = "Code" },
      { "<leader>f", group = "File/Find" },
      { "<leader>g", group = "Git" },
      { "<leader>gh", group = "Git Hunks" },
      { "<leader>t", group = "Toggle" },
      { "<leader>n", group = "Notes" },
      { "g", group = "Goto" },
      { "gx", desc = "Open with System App" },
    },
  },
}
