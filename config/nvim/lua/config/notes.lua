local function open_note(path)
  path = path:match("^%s*(.-)%s*$")

  vim.cmd("badd " .. vim.fn.fnameescape(path))
  local buffer_number = vim.fn.bufnr(path)

  vim.api.nvim_set_current_buf(buffer_number)
end

local function create_new_note(todo)
  local title = vim.fn.input("Title: ")
  if not title or string.len(title) == 0 then
    return nil
  end

  local cmd = "new"
  if todo then
    cmd = "todo"
  end

  local sb_new_output = vim.fn.system(string.format("sb %s '%s'", cmd, title:gsub("\n", "")))
  local sb_new_exit_code = vim.v.shell_error

  if sb_new_exit_code == 0 then
    open_note(sb_new_output)
  else
    vim.notify(sb_new_output, vim.log.levels.ERROR)
  end
end

local function open_note_from_link()
  local encoded_filepath = vim.fn.expand("<cfile>")
  local encoded_filename = vim.fn.fnamemodify(encoded_filepath, ":t")
  local base_dir = vim.fn.expand("%:p:h")

  if encoded_filename then
    local sb_path_output = vim.fn.system(string.format("sb path %s '%s'", base_dir, encoded_filepath)):gsub("\n", "")
    local sb_path_exit_code = vim.v.shell_error

    if sb_path_exit_code == 0 then
      open_note(sb_path_output)
    else
      vim.notify(sb_path_output, vim.log.levels.ERROR)
    end
  end
end

local function insert_link_to_note()
  local fzf = require("fzf-lua")

  local rg_cmd = "rg --files --no-ignore --type markdown"
  local cwd = os.getenv("NOTES")

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
          local sb_link_cmd = string.format("sb link '%s' '%s'", vim.fn.expand("%:p"), absolute_path)
          local sb_link_output = vim.fn.system(sb_link_cmd)
          local sb_link_exit_code = vim.v.shell_error

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

vim.keymap.set("n", "<space>nl", insert_link_to_note, { desc = "Insert Link to Note Under Cursor" })
vim.keymap.set("n", "<space>nn", function()
  create_new_note(false)
end, { desc = "Create New Note" })
vim.keymap.set("n", "<space>nt", function()
  create_new_note(true)
end, { desc = "Create New Todo" })
vim.keymap.set("n", "<space>no", open_note_from_link, { desc = "Open Note From Link" })
