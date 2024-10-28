local wezterm = require("wezterm")
local bindings = require("bindings")
-- local opacity = require("opacity")

local weztermCfg = {
  front_end = "WebGpu",
  enable_wayland = true,

  color_scheme = "Catppuccin Mocha",
  xcursor_theme = "catppuccin-mocha-dark-cursors",
  window_background_opacity = nil,

  font = wezterm.font_with_fallback({
    { family = "JetBrainsMono Nerd Font", weight = "Light" },
    "Noto Color Emoji",
  }),
  font_size = 10.0,
  line_height = 1.0,
  harfbuzz_features = { "calt=0", "clig=0", "liga=0" },

  window_decorations = "RESIZE",
  window_close_confirmation = "NeverPrompt",
  window_padding = {
    left = 1,
    right = 1,
    top = 1,
    bottom = 1,
  },

  audible_bell = "Disabled",
}

bindings.apply_to_config(weztermCfg)
-- opacity.apply_to_config(weztermCfg)
local cp_colors = {
  base = "#121212",
  crust = "#000000",
  text = "#cdd6f4",
  subtext0 = "#a6adc8",
}

weztermCfg.colors = {
  background = cp_colors.base,
  tab_bar = {
    background = cp_colors.crust,
    active_tab = {
      bg_color = cp_colors.base,
      fg_color = cp_colors.text,
      intensity = "Bold",
    },
    inactive_tab = {
      bg_color = cp_colors.crust,
      fg_color = cp_colors.subtext0,
    },
    inactive_tab_hover = {
      bg_color = cp_colors.crust,
      fg_color = cp_colors.subtext0,
    },
    new_tab = {
      bg_color = cp_colors.base,
      fg_color = cp_colors.subtext0,
    },
    new_tab_hover = {
      bg_color = cp_colors.base,
      fg_color = cp_colors.subtext0,
    },
  },
}

return weztermCfg
