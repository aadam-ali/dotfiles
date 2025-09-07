return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  -- dependencies = { "nvim-tree/nvim-web-devicons" },
  -- or if using mini.icons/mini.nvim
  dependencies = { "echasnovski/mini.icons" },
  opts = {
    fzf_colors = true,
  },
  keys = {
    {
      "<leader>fb",
      function()
        require("fzf-lua").buffers({ sort_mru = true, sort_lastused = true })
      end,
      desc = "[F]ind [B]uffers",
    },
    {
      "<leader><space>",
      function()
        local fzf = require("fzf-lua")
        local is_git = vim.fn.system("git rev-parse --is-inside-work-tree"):match("true")

        if is_git and vim.fn.getcwd() ~= os.getenv("SB") then
          fzf.git_files()
        else
          fzf.files()
        end
      end,
      desc = "Find Files (project dir)",
    },
    {
      "<leader>ff",
      function()
        local fzf = require("fzf-lua")
        local is_git = vim.fn.system("git rev-parse --is-inside-work-tree"):match("true")

        if is_git and vim.fn.getcwd() ~= os.getenv("SB") then
          fzf.git_files()
        else
          fzf.files()
        end
      end,
      desc = "[F]ind [F]iles (project dir)",
    },
    {
      "<leader>fF",
      function()
        require("fzf-lua").files({ cwd_only = true })
      end,
      desc = "[F]ind [F]iles (cwd)",
    },
    {
      "<leader>fR",
      function()
        require("fzf-lua").oldfiles()
      end,
      desc = "[F]ind [R]ecent Files",
    },
    {
      "<leader>fr",
      function()
        require("fzf-lua").oldfiles({ cwd_only = true })
      end,
      desc = "[F]ind [R]ecent Files (cwd)",
    },
    {
      "<leader>fg",
      function()
        require("fzf-lua").live_grep()
      end,
      desc = "[F]ind [G]rep",
    },
    {
      "<leader>fG",
      function()
        require("fzf-lua").lgrep_curbuf()
      end,
      desc = "[F]ind [G]rep in Current File",
    },
    {
      "<leader>fd",
      function()
        require("fzf-lua").lsp_document_diagnostics()
      end,
      desc = "[F]ind [D]iagnostics in Current File",
    },
    {
      "<leader>fD",
      function()
        require("fzf-lua").lsp_workspace_diagnostics()
      end,
      desc = "[F]ind [D]iagnostics in Workspace",
    },
  },
}
