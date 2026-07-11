local M = {}

local state_file = vim.fn.stdpath "data" .. "/lockin_state.json"

local LOCKIN_THEME = "alabaster" -- swap for whatever minimal colorscheme you use
local NORMAL_THEME = "citruszest"

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

local function nnp_toggle()
	vim.cmd "NoNeckPain"
end

function M.lock_in()
	local ok, err = pcall(vim.cmd.colorscheme, LOCKIN_THEME)
	if not ok then
		vim.notify("lockin: colorscheme failed: " .. err, vim.log.levels.ERROR)
	end

	local ok2, err2 = pcall(nnp_toggle)
	if not ok2 then
		vim.notify("lockin: NoNeckPain toggle failed: " .. err2, vim.log.levels.ERROR)
	end

	write_state(true)
	print "Locked in."
end

function M.chill()
	local ok, err = pcall(vim.cmd.colorscheme, NORMAL_THEME)
	if not ok then
		vim.notify("chill: colorscheme failed: " .. err, vim.log.levels.ERROR)
	end

	local ok2, err2 = pcall(nnp_toggle)
	if not ok2 then
		vim.notify("chill: NoNeckPain toggle failed: " .. err2, vim.log.levels.ERROR)
	end

	write_state(false)
	print "Chilling."
end

function M.setup()
	vim.api.nvim_create_user_command("LockIn", M.lock_in, {})
	vim.api.nvim_create_user_command("Chill", M.chill, {})

	local state = read_state()

	vim.schedule(function()
		if state.locked_in then
			local ok, err = pcall(vim.cmd.colorscheme, LOCKIN_THEME)
			if not ok then
				vim.notify("lockin: colorscheme failed: " .. err, vim.log.levels.ERROR)
			end
			-- NNP starts disabled on every fresh launch, so toggling once here
			-- reliably brings it to "enabled" — never call this more than once per boot.
			local ok2, err2 = pcall(nnp_toggle)
			if not ok2 then
				vim.notify("lockin: NoNeckPain toggle failed: " .. err2, vim.log.levels.ERROR)
			end
		else
			local ok, err = pcall(vim.cmd.colorscheme, NORMAL_THEME)
			if not ok then
				vim.notify("chill: colorscheme failed: " .. err, vim.log.levels.ERROR)
			end
			-- NNP is already disabled by default at startup, nothing to do.
		end
	end)
end

return M
