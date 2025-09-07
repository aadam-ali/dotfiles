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
  local exit_code = vim.v.shell_error

  if exit_code ~= 0 then
    vim.notify(note, vim.log.levels.ERROR)
  else
    open_file(note)
  end
end

local function new_note_non_interactive(title)
  local note = vim.fn.system(string.format("sb new -n '%s'", title))
  local exit_code = vim.v.shell_error

  if exit_code == 0 then
    open_file(note)
  else
    vim.notify(note, vim.log.levels.ERROR)
  end
end

local function open_note_from_markdown_link()
  local encoded_filepath = vim.fn.expand("<cfile>")
  local encoded_filename = vim.fn.fnamemodify(encoded_filepath, ":t")

  if encoded_filename then
    local filepath = vim.fn.system(string.format("sb path '%s'", encoded_filename)):gsub("\n", "")
    local exit_code = vim.v.shell_error

    if exit_code == 0 then
      open_file(filepath)
    else
      new_note_non_interactive(title)
    end
  end
end

local function open_note_from_wiki_link()
  local current_line = vim.api.nvim_get_current_line()
  local title = current_line:match("%[%[([^|%]]+)")

  if title then
    local path = vim.fn.system(string.format("sb path -w '%s'", title)):gsub("\n", "")
    local exit_code = vim.v.shell_error

    if exit_code == 0 then
      open_file(path)
    else
      new_note_non_interactive(title)
    end
  end
end

local function open_daily_note()
  vim.cmd("r!sb daily")
end

local function link_note(wiki_link)
  local fzf = require("fzf-lua")

  local rg_cmd = "rg --files --type markdown"
  local cwd = os.getenv("SB")

  local link_cmd_flags = ""
  if wiki_link then
    link_cmd_flags = "-w"
  end

  fzf.fzf_exec(rg_cmd, {
    cwd = cwd,
    prompt = "Notes> ",
    previewer = "cat",
    actions = {
      -- Map <CR> to custom function
      ["default"] = function(selected)
        local file = selected[1]
        if file then
          local absolute_path = string.format("%s/%s", cwd, file)
          local link_cmd = string.format("sb link %s '%s' '%s'", link_cmd_flags, vim.fn.expand("%:p"), absolute_path)
          local link = vim.fn.system(link_cmd)
          local exit_code = vim.v.shell_error

          if exit_code == 0 then
            vim.api.nvim_put({ link }, "c", true, true)
          else
            vim.notify(link, vim.log.levels.ERROR)
          end
        end
      end,
    },
  })
end

local function markdown_link_note()
  link_note(false)
end

local function wiki_link_note()
  link_note(true)
end


-- Register the commands as user commands
vim.api.nvim_create_user_command("SBNewNote", new_note_interactive, {})
vim.api.nvim_create_user_command("SBOpenNoteMarkdownLink", open_note_from_markdown_link, {})
vim.api.nvim_create_user_command("SBOpenNoteWikiLink", open_note_from_wiki_link, {})
vim.api.nvim_create_user_command("SBDailyNote", open_daily_note, {})
vim.api.nvim_create_user_command("SBMarkdownLinkNote", markdown_link_note, {})
vim.api.nvim_create_user_command("SBWikiLinkNote", wiki_link_note, {})

-- Register new note keybind
-- Open and Link keybinds in autoload.lua (should only open when in markdown files)
vim.keymap.set("n", "<space>nn", ":SBNewNote<CR>", { desc = "Create New Note" })
vim.keymap.set("n", "<space>nd", "G:SBDailyNote<CR>", { desc = "Insert Daily Note Entry" })
vim.keymap.set("n", "<space>no", ":SBOpenNoteMarkdownLink<CR>", { desc = "Open Note From Markdown Link" })
vim.keymap.set("n", "<space>nO", ":SBOpenNoteWikiLink<CR>", { desc = "Open Note From Wiki Link" })
vim.keymap.set("n", "<space>nl", ":SBMarkdownLinkNote<CR>", { desc = "Insert Markdown Link to Note" })
vim.keymap.set("n", "<space>nL", ":SBWikiLinkNote<CR>", { desc = "Insert Wiki Link to Note" })
