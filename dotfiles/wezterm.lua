local wezterm = require("wezterm")
-- local act = wezterm.action
-- local mux = wezterm.mux

return {
  default_prog = { "/home/clemens/.nix-profile/bin/zsh" },

  color_scheme = "Catppuccin Mocha",
  window_background_opacity = 1.0,
  window_close_confirmation = "NeverPrompt",

  font = wezterm.font_with_fallback({
    "JetbrainsMono Nerd Font",
    "Noto Color Emoji",
  }),

  harfbuzz_features = { "calt=0", "clig=0", "liga=0" }, -- disable ligatures
  warn_about_missing_glyphs = false,

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
  xcursor_theme = "Catppuccin-Mocha-Dark-Cursors",
  font_size = 10.0,
  line_height = 0.9,
  window_decorations = "RESIZE",
}
