local wezterm = require("wezterm")
local action = wezterm.action
local mux = wezterm.mux

local config = {}
local keys = {}
local mouse_bindings = {}
local launch_menu = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

for i = 1, 8 do
	table.insert(keys, {
		key = tostring(i),
		mods = "CTRL|ALT",
		action = action.ActivateTab(i - 1),
	})
end
table.insert(keys, {
	key = "t",
	mods = "CTRL|ALT",
	action = action.SpawnTab("CurrentPaneDomain"),
})
table.insert(keys, {
	key = "-",
	mods = "CTRL|ALT",
	action = action.MoveTabRelative(-1),
})
table.insert(keys, {
	key = "+",
	mods = "CTRL|ALT",
	action = action.MoveTabRelative(1),
})
table.insert(keys, {
	key = "V",
	mods = "CTRL",
	action = action.PasteFrom("Clipboard"),
})

config.font_size = 11
config.font = wezterm.font_with_fallback({ "Fira Code", "JetBrains Mono" })
config.color_scheme = "tokyonight_storm"
config.disable_default_key_bindings = true
config.keys = keys
config.launch_menu = launch_menu
config.mouse_bindings = mouse_bindings

--- Set Pwsh as the default on Windows
config.default_prog = { "pwsh.exe", "-NoLogo" }

-- This is used to make my foreground (text, etc) brighter than my background
config.foreground_text_hsb = {
	hue = 1.0,
	saturation = 1.2,
	brightness = 1.5,
}

-- This is used to set an image as my background
config.background = {
	{
		source = { File = { path = "C:/Users/someuserboi/Pictures/Backgrounds/theone.gif", speed = 0.2 } },
		opacity = 1,
		width = "100%",
		hsb = { brightness = 0.5 },
	},
}

wezterm.on("gui-startup", function()
	local _, _, window = mux.spawn_window({})
	window:gui_window():maximize()
end)

config.default_domain = "WSL:FedoraLinux-44"

return config
