local wezterm = require("wezterm")
local act = wezterm.action
local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")
resurrect.periodic_save({ interval_seconds = 60 }) -- Save every 60 seconds
wezterm.on("gui-startup", resurrect.resurrect_on_gui_startup)

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
	{
		key = "E",
		mods = "CTRL|SHIFT",
		action = act.PromptInputLine({
			description = "Enter new name for tab",
			-- initial_value = "My Tab Name",
			action = wezterm.action_callback(function(window, pane, line)
				-- line will be `nil` if they hit escape without entering anything
				-- An empty string if they just hit enter
				-- Or the actual line of text they wrote
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
	{
		key = "w",
		mods = "ALT",
		action = wezterm.action_callback(function(win, pane)
			resurrect.save_state(resurrect.workspace_state.get_workspace_state())
		end),
	},
	{
		key = "W",
		mods = "ALT",
		action = resurrect.window_state.save_window_action(),
	},
	{
		key = "T",
		mods = "ALT",
		action = resurrect.tab_state.save_tab_action(),
	},
	{
		key = "s",
		mods = "ALT",
		action = wezterm.action_callback(function(win, pane)
			resurrect.save_state(resurrect.workspace_state.get_workspace_state())
			resurrect.window_state.save_window_action()
		end),
	},
}

if wezterm.target_triple:find("windows") then
	config.default_prog = { "C:\\Program Files\\PowerShell\\7\\pwsh.exe" }
end

return config
