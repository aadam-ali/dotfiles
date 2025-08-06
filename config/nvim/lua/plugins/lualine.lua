return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      tabline = {
        lualine_a = {
          {
            "buffers",
            show_filename_only = false,
            show_modified_status = true,
            mode = 0,
            max_length = vim.o.columns,
          },
        },
      },
    },
  },
}
