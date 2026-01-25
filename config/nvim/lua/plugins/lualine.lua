return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      tabline = {
        lualine_a = {
          {
            "buffers",
            max_length = vim.o.columns,
            mode = 0,
            show_filename_only = true,
            show_modified_status = true,
          },
        },
      },
    },
  },
}
