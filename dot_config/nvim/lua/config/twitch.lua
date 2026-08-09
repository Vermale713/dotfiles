local M = {}

local state_file = vim.fn.stdpath "data" .. "/lockin_state.json"
local LIGHT_THEME = "zellner"
local DEFAULT_MINUTES = 5

local timer = nil

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

-- what theme *should* be active right now, based on lockin.nvim's persisted
-- state — deliberately doesn't touch NoNeckPain, light mode is theme-only
local function home_theme()
	return read_state().locked_in and "lockin" or "citruszest"
end

local function set_theme(theme, label)
	local ok, err = pcall(vim.cmd.colorscheme, theme)
	if not ok then
		vim.notify(label .. ": colorscheme failed: " .. err, vim.log.levels.ERROR)
	end
end

function M.light_mode(minutes)
	minutes = minutes or DEFAULT_MINUTES

	-- calling it again just resets the clock instead of stacking timers
	if timer then
		timer:close()
		timer = nil
	end

	set_theme(LIGHT_THEME, "light_mode")
	print(("Light mode on for %d minute(s)."):format(minutes))

	timer = vim.defer_fn(function()
		set_theme(home_theme(), "light_mode revert")
		print "Light mode off."
		timer = nil
	end, minutes * 60 * 1000)
end

function M.cancel()
	if not timer then
		return
	end
	timer:close()
	timer = nil
	set_theme(home_theme(), "light_mode cancel")
	print "Light mode cancelled."
end

function M.setup()
	vim.api.nvim_create_user_command("LightMode", function(opts)
		M.light_mode(tonumber(opts.args))
	end, { nargs = "?" }) -- :LightMode or :LightMode 10

	vim.api.nvim_create_user_command("LightModeCancel", M.cancel, {})
end

return M
