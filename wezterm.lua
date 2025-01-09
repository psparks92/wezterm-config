local wezterm = require("wezterm")
local act = wezterm.action

local config = {
	automatically_reload_config = true,
	front_end = "OpenGL",
	max_fps = 144,
	default_cursor_style = "BlinkingBlock",
	animation_fps = 1,
	cursor_blink_rate = 500,
	term = "xterm-256color", -- Set the terminal type,
	--enable_tab_bar = false,
	window_close_confirmation = "NeverPrompt",
	window_decorations = "RESIZE",
	color_scheme = "Nord (Gogh)",
	font = wezterm.font("Hack Nerd Font Mono", { weight = "Regular", italic = false }),
	font_size = 12.5,
	window_padding = {
		left = 3,
		right = 3,
		top = 0,
		bottom = 0,
	},
}

-- keymaps
config.keys = {
	-- {
	-- 	key = "E",
	-- 	mods = "CTRL|SHIFT|ALT",
	-- 	action = wezterm.action.EmitEvent("toggle-colorscheme"),
	-- },
	{
		key = "i",
		mods = "CTRL|SHIFT|ALT",
		action = wezterm.action.SplitPane({
			direction = "Right",
			size = { Percent = 50 },
		}),
	},
	{
		key = "o",
		mods = "CTRL|SHIFT|ALT",
		action = wezterm.action.SplitPane({
			direction = "Down",
			size = { Percent = 50 },
		}),
	},
	{
		key = "h",
		mods = "CTRL|ALT",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "j",
		mods = "CTRL|ALT",
		action = act.ActivatePaneDirection("Down"),
	},
	{
		key = "k",
		mods = "CTRL|ALT",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "l",
		mods = "CTRL|ALT",
		action = act.ActivatePaneDirection("Right"),
	},
	{
		key = "h",
		mods = "CTRL|ALT|SHIFT",
		action = act.AdjustPaneSize({ "Left", 5 }),
	},
	{
		key = "j",
		mods = "CTRL|ALT|SHIFT",
		action = act.AdjustPaneSize({ "Down", 5 }),
	},
	{
		key = "k",
		mods = "CTRL|ALT|SHIFT",
		action = act.AdjustPaneSize({ "Up", 5 }),
	},
	{
		key = "l",
		mods = "CTRL|ALT|SHIFT",
		action = act.AdjustPaneSize({ "Right", 5 }),
	},
	{ key = "9", mods = "CTRL", action = act.PaneSelect },
	{ key = "F9", mods = "ALT", action = wezterm.action.ShowTabNavigator },
	{
		key = "y",
		mods = "CTRL|ALT",
		action = wezterm.action.SpawnCommandInNewTab({
			args = { "top" },
		}),
	},
	-- { key = "L", mods = "CTRL", action = act.ShowDebugOverlay },
	-- {
	-- 	key = "O",
	-- 	mods = "CTRL|ALT",
	-- 	-- toggling opacity
	-- 	action = wezterm.action_callback(function(window, _)
	-- 		local overrides = window:get_config_overrides() or {}
	-- 		if overrides.window_background_opacity == 1.0 then
	-- 			overrides.window_background_opacity = 0.9
	-- 		else
	-- 			overrides.window_background_opacity = 1.0
	-- 		end
	-- 		window:set_config_overrides(overrides)
	-- 	end),
	-- },
}

if wezterm.target_triple:find("windows") then
	config.default_prog = { "C:\\Program Files\\PowerShell\\7\\pwsh.exe" }
end

return config
