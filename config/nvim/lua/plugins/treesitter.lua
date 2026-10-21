return { -- Highlight, edit, and navigate code
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",

  config = function()
    require("nvim-treesitter").install({
      "lua",
      "python",
      "vim",
      "regex",
      "terraform",
      "sql",
      "dockerfile",
      "toml",
      "json",
      "go",
      "gitignore",
      "yaml",
      "make",
      "bash",
      "diff",
      "html",
      "markdown",
      "markdown_inline",
      "vimdoc",
    })

    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
      end,
    })
  end,
}
