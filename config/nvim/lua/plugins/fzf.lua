local H = {}

H.find_files = function()
  local fzf = require("fzf-lua")
  local is_git = vim.fn.system("git rev-parse --is-inside-work-tree"):match("true")

  cwd = vim.fn.getcwd():gsub("/$", "")
  sb = os.getenv("SB"):gsub("/$", "")

  if cwd == sb or cwd:sub(1, #sb + 1) == sb .. "/" then
    fzf.files({ cwd = sb, rg_opts = "--files --no-ignore --glob '!.git/*'" })
  elseif is_git then
    fzf.git_files()
  else
    fzf.files({ rg_opts = "--files --no-ignore --glob '!*/.git/*' --glob '!*/.venv/*'" })
  end
end

return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    fzf_colors = true,
    winopts = {
      border = "solid",
      preview = {
        border = "solid",
      },
    },
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
        H.find_files()
      end,
      desc = "Find Files (project dir)",
    },
    {
      "<leader>ff",
      function()
        H.find_files()
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
        require("fzf-lua").live_grep({ rg_opts = "--no-ignore " .. require("fzf-lua").defaults.grep.rg_opts })
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
