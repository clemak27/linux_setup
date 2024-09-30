local wezterm = require("wezterm")
local bindings = require("bindings")

local custom_colors = {
  base = "#11111b",
  crust = "#1e1e2e",
  text = "#cdd6f4",
  subtext0 = "#a6adc8",
}

local weztermCfg = {
  front_end = "WebGpu",
  enable_wayland = true,

  color_scheme = "Catppuccin Mocha",
  colors = {
    background = custom_colors.base,
    tab_bar = {
      background = custom_colors.base,
      active_tab = {
        bg_color = custom_colors.crust,
        fg_color = custom_colors.text,
        intensity = "Bold",
      },
      inactive_tab = {
        bg_color = custom_colors.base,
        fg_color = custom_colors.subtext0,
      },
      inactive_tab_hover = {
        bg_color = custom_colors.base,
        fg_color = custom_colors.subtext0,
      },
      new_tab = {
        bg_color = custom_colors.crust,
        fg_color = custom_colors.subtext0,
      },
      new_tab_hover = {
        bg_color = custom_colors.crust,
        fg_color = custom_colors.subtext0,
      },
    },
  },

  window_background_opacity = 0.8,
  xcursor_theme = "catppuccin-mocha-dark-cursors",

  font = wezterm.font_with_fallback({
    { family = "JetBrainsMono Nerd Font", weight = "Light" },
    "Noto Color Emoji",
  }),
  harfbuzz_features = { "calt=0", "clig=0", "liga=0" }, -- disable ligatures
  warn_about_missing_glyphs = false,
  font_size = 10.0,
  line_height = 0.9,

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

bindings.apply_to_config(weztermCfg)

return weztermCfg
