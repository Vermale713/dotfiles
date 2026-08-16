local M = {}

local state_file = vim.fn.stdpath "data" .. "/lockin_state.json"

local LOCKIN_THEME = "lockin"
local NORMAL_THEME = "lockin"

-- our own source of truth for whether NNP is currently on,
-- so we never have to guess/toggle blind
local nnp_enabled = false

local function write_state(locked_in)
	local f = io.open(state_file, "w")
	if f then
		f:write(vim.json.encode { locked_in = locked_in })
		f:close()
	end
end

local function read_state()
	local f = io.open(state_file, "r")
	if not f then
		return { locked_in = false }
	end
	local content = f:read "*a"
	f:close()
	local ok, decoded = pcall(vim.json.decode, content)
	if ok and decoded then
		return decoded
	end
	return { locked_in = false }
end

-- only toggles NNP if it isn't already in the desired state
local function set_nnp(enabled)
	if enabled == nnp_enabled then
		return
	end
	local ok, err = pcall(vim.cmd, "NoNeckPain")
	if not ok then
		vim.notify("lockin: NoNeckPain toggle failed: " .. err, vim.log.levels.ERROR)
		return
	end
	nnp_enabled = enabled
end

local function apply(locked_in, verb)
	local theme = locked_in and LOCKIN_THEME or NORMAL_THEME
	local ok, err = pcall(vim.cmd.colorscheme, theme)
	if not ok then
		vim.notify(verb .. ": colorscheme failed: " .. err, vim.log.levels.ERROR)
	end
	set_nnp(locked_in)
	write_state(locked_in)
end

function M.lock_in()
	apply(true, "lockin")
	print "Locked in."
end

function M.chill()
	apply(false, "chill")
	print "Chilling."
end

function M.setup()
	vim.api.nvim_create_user_command("LockIn", M.lock_in, {})
	vim.api.nvim_create_user_command("Chill", M.chill, {})

	local state = read_state()

	vim.schedule(function()
		apply(state.locked_in, "startup")
	end)
end

return M
