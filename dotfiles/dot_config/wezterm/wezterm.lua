local wezterm = require("wezterm")
local bindings = require("bindings")

local cp_colors = {
  base = "#121212",
  crust = "#000000",
  text = "#cdd6f4",
  subtext0 = "#a6adc8",
}

local accentColor = "#555095"

local weztermCfg = {
  xcursor_theme = "breeze_cursors",

  front_end = "OpenGL",
  enable_wayland = true,

  color_scheme = "Catppuccin Mocha",
  window_background_opacity = 0.8,
  colors = {
    background = "#000000",
    split = accentColor,
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
  },
  inactive_pane_hsb = {
    saturation = 1.0,
    brightness = 1.0,
  },

  font = wezterm.font_with_fallback({
    { family = "JetBrainsMonoNL Nerd Font" },
    "Noto Color Emoji",
  }),
  font_size = 10.0,
  line_height = 1.0,
  harfbuzz_features = { "calt=0", "clig=0", "liga=0" },

  window_decorations = "TITLE | RESIZE",
  window_close_confirmation = "NeverPrompt",
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },

  audible_bell = "Disabled",
  warn_about_missing_glyphs = false,
}

bindings.apply_to_config(weztermCfg)

return weztermCfg
