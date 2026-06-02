local wezterm = require 'wezterm'
local action = wezterm.action
local mux = wezterm.mux

local config = {}
local keys = {}
local mouse_bindings = {}
local launch_menu = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

local home_dir = wezterm.home_dir

config.font_size = 11
config.font = wezterm.font_with_fallback({'Fira Code','JetBrains Mono'})
config.color_scheme = 'tokyonight_storm'
config.disable_default_key_bindings = true
config.keys = { { key = 'V', mods = 'CTRL', action = action.PasteFrom('Clipboard') }, } 
-- config.default_cwd = wezterm.home_dir .. '/projects'

--- Set Pwsh as the default on Windows
config.default_prog = { 'pwsh.exe', '-NoLogo' }

mouse_bindings = {
	{
		event = { Down = { streak = 3, button = 'Left' } },
		action = wezterm.action.SelectTextAtMouseCursor 'SemanticZone',
		mods = 'NONE',
	},
	{
		event = { Down = { streak = 1, button = "Right" } },
		mods = "NONE",
		action = wezterm.action_callback(function(window, pane)
			local has_selection = window:get_selection_text_for_pane(pane) ~= ""
			if has_selection then
				window:perform_action(action.CopyTo("ClipboardAndPrimarySelection"), pane)
				window:perform_action(action.ClearSelection, pane)
			else
				window:perform_action(action({ PasteFrom = "Clipboard" }), pane)
			end
		end),
	},
}

-- This is used to make my foreground (text, etc) brighter than my background
config.foreground_text_hsb = {
	hue = 1.0,
	saturation = 1.2,
	brightness = 1.5,
}

-- This is used to set an image as my background
config.background = {
	{
		source = { File = { path = 'C:/Users/someuserboi/Pictures/Backgrounds/theone.gif', speed = 0.2 } },
		opacity = 1,
		width = "100%",
		hsb = { brightness = 0.5 },
	}
}


wezterm.on("gui-startup", function()
  local tab, pane, window = mux.spawn_window{}
  window:gui_window():maximize()
end)

return config
