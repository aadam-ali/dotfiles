return {
  "williamboman/mason.nvim",
  opts = {
    ensure_installed = {
      "ansible-language-server",
      "flake8",
      "gopls",
      "pyright",
      "shellcheck",
      "terraform-ls",
      "yaml-language-server",
    },
  },
}
