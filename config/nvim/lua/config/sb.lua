local function open_note(path)
  path = path:match("^%s*(.-)%s*$")

  vim.cmd("badd " .. vim.fn.fnameescape(path))
  buffer_number = vim.fn.bufnr(path)

  vim.api.nvim_set_current_buf(buffer_number)
end

local function create_new_note(remove_date)
  title = vim.fn.input("Title: ")
  if not title or string.len(title) == 0 then
    return nil
  end

  cmd_flags = "-n"
  if remove_date then
    cmd_flags = cmd_flags .. " -d"
  end

  sb_new_output = vim.fn.system(string.format("sb new %s '%s'", cmd_flags, title:gsub("\n", "")))
  sb_new_exit_code = vim.v.shell_error

  if sb_new_exit_code == 0 then
    open_note(sb_new_output)
  else
    vim.notify(sb_new_output, vim.log.levels.ERROR)
  end
end

local function open_note_from_link()
  encoded_filepath = vim.fn.expand("<cfile>")
  encoded_filename = vim.fn.fnamemodify(encoded_filepath, ":t")

  if encoded_filename then
    sb_path_output = vim.fn.system(string.format("sb path '%s'", encoded_filename)):gsub("\n", "")
    sb_path_exit_code = vim.v.shell_error

    if sb_path_exit_code == 0 then
      open_note(sb_path_output)
    else
      vim.notify(sb_path_output, vim.log.levels.ERROR)
    end
  end
end

local function insert_link_to_note()
  fzf = require("fzf-lua")

  rg_cmd = "rg --files --no-ignore --type markdown"
  cwd = os.getenv("SB")

  link_cmd_flags = ""

  fzf.fzf_exec(rg_cmd, {
    cwd = cwd,
    prompt = "Notes> ",
    previewer = "cat",
    actions = {
      -- Map <CR> to custom function
      ["default"] = function(selected)
        file = selected[1]
        if file then
          absolute_path = string.format("%s/%s", cwd, file)
          sb_link_cmd = string.format("sb link %s '%s' '%s'", link_cmd_flags, vim.fn.expand("%:p"), absolute_path)
          sb_link_output = vim.fn.system(sb_link_cmd)
          sb_link_exit_code = vim.v.shell_error

          if sb_link_exit_code == 0 then
            vim.api.nvim_put({ sb_link_output }, "c", true, true)
          else
            vim.notify(sb_link_output, vim.log.levels.ERROR)
          end
        end
      end,
    },
  })
end

local function insert_todo()
  id = vim.fn.input("ID: ", os.date("%Y%m%d") .. "-XXX")
  todo = vim.fn.input("To Do: ")

  if not todo or string.len(todo) == 0 then
    return nil
  end

  vim.api.nvim_put({ string.format("    - [ ] [%s] %s", id, todo) }, "c", true, true)
end

vim.keymap.set("n", "<space>nN", function()
  create_new_note(true)
end, { desc = "Create New Note Without Date in Filename" })
vim.keymap.set("n", "<space>nT", insert_todo, { desc = "Insert To Do Under Cursor" })
vim.keymap.set("n", "<space>nd", function()
  vim.cmd("$read !sb daily")
end, { desc = "Insert Daily Note Template" })
vim.keymap.set("n", "<space>nl", insert_link_to_note, { desc = "Insert Link to Note Under Cursor" })
vim.keymap.set("n", "<space>nn", create_new_note, { desc = "Create New Note" })
vim.keymap.set("n", "<space>no", open_note_from_link, { desc = "Open Note From Link" })
vim.keymap.set("n", "<space>nt", function()
  vim.api.nvim_put({ os.date("%H:%M") }, "c", true, true)
end, { desc = "Insert Current Time Under Cursor" })
