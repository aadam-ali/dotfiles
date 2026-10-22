return { -- Highlight, edit, and navigate code
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",

  config = function()
    require("nvim-treesitter").install({
      "bash",
      "diff",
      "dockerfile",
      "gitcommit",
      "gitignore",
      "go",
      "html",
      "json",
      "lua",
      "make",
      "markdown",
      "markdown_inline",
      "python",
      "regex",
      "sql",
      "terraform",
      "toml",
      "vim",
      "vimdoc",
      "yaml",
    })

    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
      end,
    })
  end,
}
