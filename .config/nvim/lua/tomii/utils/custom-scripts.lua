-- some utility scripts
-- Telescope required
-- TODO: this is NOT optimized AT ALL
local M = {}

local is_linux = require("tomii.utils.check-os")

M.terminal_command = "tabedit term://zsh -i -c"

-- pops up a menu from Telescope to select from different options
-- options it's a table with the options
-- menu_msg it's the message of the prompt
-- it returns the selection synchronously
local function selection_menu(options, menu_msg, callback)
	local actions = require("telescope.actions")
	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local sorters = require("telescope.sorters")
	local previewers = require("telescope.previewers")
	local conf = require("telescope.config").values

	local results = nil
	local entry_maker = function(line)
		return {
			value = line,
			display = line,
			ordinal = line,
		}
	end

	local opts = {
		sorting_strategy = "ascending",
		layout_strategy = "horizontal",
		prompt = menu_msg,
		finder = finders.new_table({
			results = options,
			entry_maker = entry_maker,
		}),
		previewer = previewers.cat.new({}),
		sorter = sorters.get_fuzzy_file(),
		attach_mappings = function(prompt_bufnr, map)
			actions.select_default:replace(function()
				actions.close(prompt_bufnr)
        local action_state = require "telescope.actions.state"
				local selection = action_state.get_selected_entry()
        local value = selection.value
				-- print("selection: " .. vim.inspect(selection))
        callback(value)
				vim.api.nvim_put({ selection[1] }, "", false, true)
			end)
			return true
		end,
	}

	local prompt = pickers.new(opts, {
		prompt_title = menu_msg,
		finder = finders.new_table(options),
		sorter = conf.generic_sorter(opts),
	})

	prompt:find()
end

-- runs an OS command
local function run_command(command)
	print("Running: " .. command)
	vim.cmd(M.terminal_command .. " " .. "'" .. command .. "'")
end

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
	else
		print("ERROR: bad argument. Called in custom-scripts.lua")
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

-- run an octave script in a new terminal tab
M.run_octave_script = function(script_name)
	local command = "octave --traditional " .. script_name
	run_command(command)
end

M.run_node_script = function(package_manager)
	-- TODO this should read the package.json file and give the options of running a script
	local command = package_manager .. " compile"
	run_command(command)
end

local function run_particular_script_file(file)
	if file == "main.m" then
		M.run_octave_script(file)
	elseif file == "yarn.lock" then
		M.run_node_script("yarn")
	elseif file == "package-lock.json" then
		M.run_node_script("npm")
	end
end

local function ask_what_file_to_run(files)
	-- runs the script for a particular file
	local file_list = ""
	for i, file in ipairs(files) do
		file_list = file_list .. "[" .. tostring(i) .. "] " .. file
		if i < #files then
			file_list = file_list .. ", "
		end
	end

	local file_index = vim.fn.input("For what file compile ('q' to cancel) " .. file_list .. "? ")

	if file_index == "" or file_index == "q" then
		return nil
	end

	return files[tonumber(file_index)]
end

-- given a comment and an index returns the option formatted to be concatenated
local function format_command_option(comment, index, last_index)
	local message = "(" .. tostring(index) .. ") " .. comment
	if not last_index then
		message = message .. ", "
	end
	return message
end

-- returns a table containing the lines of a file
-- if the file does not exist returns nil.
local function get_lines_from_file(filename)
	local lines = {}
	local config = io.open(filename, "r")

	if config == nil then
		return nil
	end

	for line in config:lines() do
		table.insert(lines, line)
	end

	config:close()

	return lines
end

-- returns boolean, true if .nvim_compile_config exists
local function has_local_compile_config()
	local filename = ".nvim_compile_config"
	local lines = get_lines_from_file(filename)
	if lines and #lines > 0 then
		return true
	else
		return false
	end
end

-- the workspace config should be a file called: .nvim_config
-- the file should contain what command to run
local function run_workspace_commands()
	local filename = ".nvim_compile_config"
	local lines = get_lines_from_file(filename)

	if not lines then
		return
	end

	-- just run the command if there's only 1 line
	if #lines == 1 then
		return lines[1]
	end

	local data = {}
	local message = "Pick a command: "
	local commands = {}
	local linenumber = 1
	while linenumber < #lines + 1 do
		local comment_index = linenumber
		local command_index = linenumber + 1
		data[linenumber] = {}

		local comment = lines[command_index]
		local command = lines[command_index]

		data[linenumber]["comment"] = comment
		message = format_command_option(comment, comment_index, not data[linenumber + 1])

		data[linenumber]["command"] = command
		commands[#commands + 1] = command

		linenumber = linenumber + 2
	end

	print(vim.inspect(commands))

	selection_menu(commands, "Pick a command", run_command)
end

-- compiles/runs the main file of the current project
-- should auto detect the programming language
-- 'side' it's to compile opening the terminal in different places
M.run_main_script = function(side)
	M.set_terminal_command(side)

	-- checks if the .nvim_compile_config exists and then it runs the commands
	if has_local_compile_config() then
		run_workspace_commands()
		return
	end

	local main_filenames = { "yarn.lock", "package-lock.json", "main.m", "Makefile", "main.c" }
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

M.run_current_script = function(side)
	M.set_terminal_command(side)

	local bufnr = vim.api.nvim_get_current_buf()
	local file = vim.api.nvim_buf_get_name(bufnr)
	local filename = vim.fs.basename(file)

	M.run_octave_script(filename)
end

-- makes git add and git commit -m for the current file
M.add_commit_current_file = function()
	local filepath = vim.fn.expand("%")
	local commit_message = vim.fn.input("Commit msg (or press 'q' to cancel): ")
	if commit_message == "q" or commit_message == "" then
		print("Commit cancel")
		return
	end
	os.execute("git add " .. filepath)
	os.execute("git commit -m " .. '"' .. commit_message .. '"')
end

return M
