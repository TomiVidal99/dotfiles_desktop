-- Some custom functions.

-- Git
-- Add current file and prompt for a message to commit.
function add_commit_current_file()
  filepath=vim.fn.expand("%")
  print(filepath)
  os.execute("git add " .. filepath)
  commit_message = vim.fn.input("Commit msg: ")
  os.execute("git commit -m " .. "\"" .. commit_message .. "\"")
  print("")
end
vim.keymap.set("n", ",C", add_commit_current_file, {expr = true})
