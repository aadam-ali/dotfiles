local function open_file(file_path)
  file_path = file_path:gsub("\n", ""):match("^%s*(.-)%s*$")

  vim.cmd("badd " .. vim.fn.fnameescape(file_path))
  local buffer_number = vim.fn.bufnr(file_path)

  vim.api.nvim_set_current_buf(buffer_number)
end

local function new_note_interactive()
  local title = vim.fn.input("Title")
  if not title or string.len(title) == 0 then
    return nil
  end

  local note = vim.fn.system(string.format("sb new -n '%s'", title))

  open_file(note)
end

local function new_note_non_interactive(title)
  local note = vim.fn.system(string.format("sb new -n '%s'", title))

  open_file(note)
end

local function open_note()
  local current_line = vim.api.nvim_get_current_line()
  local title = current_line:match("%[%[([^|%]]+)")

  if title then
    local path = vim.fn.system(string.format("sb path '%s'", title)):gsub("\n", "")

    if path ~= "" then
      open_file(path)
    else
      new_note_non_interactive(title)
    end
  end
end

local function open_daily_note()
  local path = vim.fn.system("sb daily -n"):gsub("Note already exists:", "")

  open_file(path)
end

local function link_note()
  local fzf = require("fzf-lua")

  local rg_cmd = "rg --files --type markdown"
  local cwd = os.getenv("SB")

  fzf.fzf_exec(rg_cmd, {
    cwd = cwd,
    prompt = "Notes> ",
    actions = {
      -- Map <CR> to custom function
      ["default"] = function(selected)
        local file = selected[1]
        if file then
          local link = string.format("[[%s]]", file:match("^.+/(.+).md$"))
          vim.api.nvim_put({ link }, "c", true, true)
        end
      end,
    },
  })
end

-- Register the commands as user commands
vim.api.nvim_create_user_command("SBNewNote", new_note_interactive, {})
vim.api.nvim_create_user_command("SBOpenNote", open_note, {})
vim.api.nvim_create_user_command("SBDailyNote", open_daily_note, {})
vim.api.nvim_create_user_command("SBLinkNote", link_note, {})

-- Register new note keybind
-- Open and Link keybinds in autoload.lua (should only open when in markdown files)
vim.keymap.set("n", "<space>nn", ":SBNewNote<CR>", { desc = "Create New Note" })
vim.keymap.set("n", "<space>nd", ":SBDailyNote<CR>", { desc = "Open Daily Note" })
vim.keymap.set("n", "<space>no", ":SBOpenNote<CR>", { desc = "Open Note From Link" })
vim.keymap.set("n", "<space>nl", ":SBLinkNote<CR>", { desc = "Insert Link to Note" })
