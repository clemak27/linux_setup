local wezterm = require("wezterm")
local act = wezterm.action

wezterm.on("update-right-status", function(window, pane)
  local name = window:active_key_table()
  if name == "tab_mode" then
    name = wezterm.format({
      { Attribute = { Intensity = "Bold" } },
      { Foreground = { Color = "#fab387" } },
      { Text = " TAB " },
    })
  elseif name == "pane_mode" then
    name = wezterm.format({
      { Attribute = { Intensity = "Bold" } },
      { Foreground = { Color = "#fab387" } },
      { Text = " PANE " },
    })
  elseif name == "resize_mode" then
    name = wezterm.format({
      { Attribute = { Intensity = "Bold" } },
      { Foreground = { Color = "#fab387" } },
      { Text = " RESIZE " },
    })
  end

  window:set_left_status(name or " ")
  window:set_right_status("")
end)

wezterm.on("switch-to-left", function(window, pane)
  local tab = window:mux_window():active_tab()

  if tab:get_pane_direction("Left") ~= nil then
    window:perform_action(wezterm.action.ActivatePaneDirection("Left"), pane)
  else
    window:perform_action(wezterm.action.ActivateTabRelative(-1), pane)
  end
end)

wezterm.on("switch-to-right", function(window, pane)
  local tab = window:mux_window():active_tab()

  if tab:get_pane_direction("Right") ~= nil then
    window:perform_action(wezterm.action.ActivatePaneDirection("Right"), pane)
  else
    window:perform_action(wezterm.action.ActivateTabRelative(1), pane)
  end
end)

local module = {}

function module.apply_to_config(config)
  config.enable_tab_bar = true
  config.use_fancy_tab_bar = false
  config.tab_max_width = 64
  config.show_new_tab_button_in_tab_bar = false

  config.inactive_pane_hsb = {
    saturation = 1.0,
    brightness = 1.0,
  }

  config.keys = {
    {
      key = "t",
      mods = "CTRL",
      action = act.ActivateKeyTable({ name = "tab_mode", one_shot = true }),
    },
    {
      key = "p",
      mods = "CTRL",
      action = act.ActivateKeyTable({ name = "pane_mode", one_shot = true }),
    },
    {
      key = "n",
      mods = "CTRL",
      action = act.ActivateKeyTable({ name = "resize_mode", one_shot = false }),
    },
    { key = "q", mods = "CTRL", action = act.PaneSelect({ mode = "SwapWithActiveKeepFocus" }) },
    { key = "LeftArrow", mods = "ALT", action = wezterm.action.EmitEvent("switch-to-left") },
    { key = "h", mods = "ALT", action = wezterm.action.EmitEvent("switch-to-left") },
    { key = "DownArrow", mods = "ALT", action = act.ActivatePaneDirection("Down") },
    { key = "j", mods = "ALT", action = act.ActivatePaneDirection("Down") },
    { key = "UpArrow", mods = "ALT", action = act.ActivatePaneDirection("Up") },
    { key = "k", mods = "ALT", action = act.ActivatePaneDirection("Up") },
    { key = "RightArrow", mods = "ALT", action = wezterm.action.EmitEvent("switch-to-right") },
    { key = "l", mods = "ALT", action = wezterm.action.EmitEvent("switch-to-right") },
  }
  local resize_inc = 5
  config.key_tables = {
    tab_mode = {
      {
        key = "n",
        action = act.SpawnCommandInNewTab({
          domain = "DefaultDomain",
          cwd = os.getenv("HOME"),
        }),
      },
      {
        key = "r",
        action = act.PromptInputLine({
          description = "Enter new name for tab",
          action = wezterm.action_callback(function(window, pane, line)
            if line then
              window:active_tab():set_title(line)
            end
          end),
        }),
      },
      { key = "x", action = act.CloseCurrentTab({ confirm = false }) },
      { key = "Escape", action = "PopKeyTable" },
    },
    pane_mode = {
      { key = "r", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
      { key = "d", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
      { key = "f", action = act.TogglePaneZoomState },
      { key = "x", action = act.CloseCurrentPane({ confirm = false }) },
      { key = "Escape", action = "PopKeyTable" },
    },
    resize_mode = {
      { key = "LeftArrow", action = act.AdjustPaneSize({ "Left", resize_inc }) },
      { key = "h", action = act.AdjustPaneSize({ "Left", resize_inc }) },
      { key = "DownArrow", action = act.AdjustPaneSize({ "Down", resize_inc }) },
      { key = "j", action = act.AdjustPaneSize({ "Down", resize_inc }) },
      { key = "UpArrow", action = act.AdjustPaneSize({ "Up", resize_inc }) },
      { key = "k", action = act.AdjustPaneSize({ "Up", resize_inc }) },
      { key = "RightArrow", action = act.AdjustPaneSize({ "Right", resize_inc }) },
      { key = "l", action = act.AdjustPaneSize({ "Right", resize_inc }) },
      { key = "Escape", action = "PopKeyTable" },
    },
  }
end

return module
