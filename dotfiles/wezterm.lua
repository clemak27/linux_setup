local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux

return {
	color_scheme = "Catppuccin Mocha",
	window_background_opacity = 1.0,
	window_close_confirmation = "NeverPrompt",

	font = wezterm.font_with_fallback({
		"FiraCode Nerd Font",
		"Noto Color Emoji",
	}),

	-- disable ligatures
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },

	enable_tab_bar = false,
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
	audible_bell = "Disabled",
	hide_mouse_cursor_when_typing = false,

	enable_wayland = true,
	font_size = 10.0,
	window_decorations = "RESIZE",
	-- window_frame = {
	-- 	border_left_width = "0.1cell",
	-- 	border_right_width = "0.1cell",
	-- 	border_bottom_height = "0.1cell",
	-- 	border_top_height = "0.1cell",
	-- 	border_left_color = "#181825",
	-- 	border_right_color = "#181825",
	-- 	border_bottom_color = "#181825",
	-- 	border_top_color = "#181825",
	-- },
}
