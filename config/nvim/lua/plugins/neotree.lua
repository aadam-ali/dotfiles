return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons", -- optional, but recommended
  },
  cmd = "Neotree",
  lazy = false, -- neo-tree will lazily load itself
  opts = {
    filesystem = {
      hijack_netrw_behavior = "open_current", -- open in fullscreen when passing in a directory
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = vim.fn.getcwd() ~= os.getenv("SB"),
        hide_by_name = {
          ".git",
        },
      },
    },
  },
  keys = {
    {
      "<leader>e",
      function()
        require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
      end,
      desc = "Open File Explorer (cwd)",
    },
  },
}
