return { -- Highlight, edit, and navigate code
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  main = "nvim-treesitter.configs", -- Sets main module to use for opts
  -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
  opts = {
    ensure_installed = {
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
    },
    auto_install = true,
    highlight = {
      enable = true,
    },
  },
  -- There are additional nvim-treesitter modules that you can use to interact
  -- with nvim-treesitter. You should go explore a few and see what interests you:
  --
  --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
  --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
  --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
}
