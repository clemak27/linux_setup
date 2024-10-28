local wezterm = require("wezterm")

local cp_colors = {
  base = "#121212",
  crust = "#000000",
  text = "#cdd6f4",
  subtext0 = "#a6adc8",
}

wezterm.on("toggle-opacity", function(window, pane)
  local overrides = window:get_config_overrides() or {}
  if not overrides.window_background_opacity then
    overrides.window_background_opacity = 0.80
    overrides.colors = {
      background = cp_colors.crust,
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
  else
    overrides.window_background_opacity = nil
    overrides.colors = {
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
  end
  window:set_config_overrides(overrides)
end)

local module = {}

function module.apply_to_config(config)
  config.inactive_pane_hsb = {
    saturation = 1.0,
    brightness = 1.0,
  }

  table.insert(config.keys, {
    key = "B",
    mods = "CTRL",
    action = wezterm.action.EmitEvent("toggle-opacity"),
  })
end

return module
