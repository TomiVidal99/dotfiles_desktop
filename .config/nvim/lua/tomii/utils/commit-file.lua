-- TODO: migrate keymap to keymaps.lua
-- Add current file and prompt for a message to commit.
local function add_commit_current_file()
  local filepath = vim.fn.expand("%")
  local commit_message = vim.fn.input("Commit msg (or press 'q' to cancel): ")
  if (commit_message == "q" or commit_message == "") then
    print "Commit cancel"
    return
  end
  os.execute("git add " .. filepath)
  os.execute("git commit -m " .. "\"" .. commit_message .. "\"")
end
vim.keymap.set("n", "<leader>ga", add_commit_current_file, { expr = true, noremap = true, silent = true })
