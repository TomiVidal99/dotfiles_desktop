-- some utility scripts
local M = {}

local is_linux = require("tomii.utils.check-os")

M.terminal_command = "tabedit term://zsh -i -c"

-- sets weather the terminal should open in a new tab, vertically or horizontally
function M.set_terminal_command(side)
  if not is_linux() then
    print("ERROR: cant run this script if not in Linux!")
    return
  end

  if side == "t" then
    M.terminal_command = "tabedit term://zsh -i -c"
  elseif side == "v" then
    M.terminal_command = "vsplit term://zsh -i -c"
  elseif side == "h" then
    M.terminal_command = "split term://zsh -i -c"
  end
end

function M.normalize_path(path, opts)
	opts = opts or {}

	vim.validate({
		path = { path, { "string" } },
		expand_env = { opts.expand_env, { "boolean" }, true },
	})

	if path:sub(1, 1) == "~" then
		local home = vim.loop.os_homedir() or "~"
		if home:sub(-1) == "\\" or home:sub(-1) == "/" then
			home = home:sub(1, -2)
		end
		path = home .. path:sub(2)
	end

	if opts.expand_env == nil or opts.expand_env then
		path = path:gsub("%$([%w_]+)", vim.loop.os_getenv)
	end

	path = path:gsub("\\", "/"):gsub("/+", "/")

	return path:sub(-1) == "/" and path:sub(1, -2) or path
end

local function find_files(filenames)
	local matches = {}

	for _, filename in ipairs(filenames) do
		local f = io.open(filename, "r")
		if f ~= nil then
			f:close()
			table.insert(matches, filename)
		end
	end

	return matches
end

local function get_files_in_directory(directory)
	local files = {}
	local dir = vim.loop.fs_scandir(M.normalize_path(directory))

	while true do
		local name, type = vim.loop.fs_scandir_next(dir)
		if name == nil then
			break
		end
		if type == "file" then
			table.insert(files, name)
		end
	end

	return files
end

-- run an octave script in a new terminal tab
M.run_octave_script = function(script_name)
	local command = "octave --traditional " .. script_name
	vim.cmd(M.terminal_command .. " " .. "'" .. command .. "'")
end

M.run_node_script = function(package_manager)
  -- TODO this should read the package.json file and give the options of running a script
	local command = package_manager .. " compile"
  print("Running: " .. command)
	vim.cmd(M.terminal_command .. " " .. "'" .. command .. "'")
end

local function run_particular_script_file(file)
  if (file == "main.m") then
		M.run_octave_script(file)
  elseif (file == "yarn.lock") then
		M.run_node_script("yarn")
  elseif (file == "package-lock.json") then
		M.run_node_script("npm")
  end
end

local function ask_what_file_to_run(files)
  -- runs the script for a particular file
  local file_list = ""
	for i, file in ipairs(files) do
    file_list = file_list .. "[" .. tostring(i) .. "] " .. file
    if (i < #files) then
      file_list = file_list .. ", "
    end
	end

  local file_index = vim.fn.input("For what file compile ('q' to cancel) " .. file_list .. "? ")

  if (file_index == "" or file_index == "q") then
    return nil
  end

  return files[tonumber(file_index)]
end

-- compiles/runs the main file of the current project
-- should auto detect the programming language
-- 'side' it's to compile opening the terminal in different places
M.run_main_script = function(side)
	M.set_terminal_command(side)

	local main_filenames = { "yarn.lock", "package-lock.json", "main.m", "Makefile", "main.c" }
	local cwd = vim.fn.getcwd()
	local files_in_cwd = get_files_in_directory(cwd)
	local found_files = find_files(main_filenames)

	if #found_files == 0 then
		print("No main files found")
		return
	end

  if #found_files == 1 then
    run_particular_script_file(found_files[1])
  else
    local f = ask_what_file_to_run(found_files)
    if not f then
      return
    end
    run_particular_script_file(f)
  end


end

-- makes git add and git commit -m for the current file
M.add_commit_current_file = function()
  local filepath = vim.fn.expand("%")
  local commit_message = vim.fn.input("Commit msg (or press 'q' to cancel): ")
  if (commit_message == "q" or commit_message == "") then
    print "Commit cancel"
    return
  end
  os.execute("git add " .. filepath)
  os.execute("git commit -m " .. "\"" .. commit_message .. "\"")
end

return M
