local wezterm = require("wezterm")
-- local act = wezterm.action
-- local mux = wezterm.mux

return {
  default_prog = { "/usr/bin/distrobox-enter", "-n", "main" },

  -- leads to weirdly bold font
  -- front_end = "WebGpu",
  enable_wayland = true,

  color_scheme = "Catppuccin Mocha",
  colors = {
    background = "#11111b",
  },
  window_background_opacity = 0.80,
  xcursor_theme = "Catppuccin-Mocha-Dark-Cursors",

  font = wezterm.font_with_fallback({
    "JetbrainsMono Nerd Font",
    "Noto Color Emoji",
  }),
  harfbuzz_features = { "calt=0", "clig=0", "liga=0" }, -- disable ligatures
  warn_about_missing_glyphs = false,
  font_size = 10.0,
  line_height = 0.9,

  enable_tab_bar = false,
  window_close_confirmation = "NeverPrompt",
  audible_bell = "Disabled",
  hide_mouse_cursor_when_typing = false,

  window_decorations = "RESIZE",
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
}
