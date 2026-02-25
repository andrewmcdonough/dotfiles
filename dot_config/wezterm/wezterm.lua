-- ~/.config/wezterm/wezterm.lua
local wezterm = require("wezterm")
local act = wezterm.action

-- Helpers
local function pill(text, bg, fg)
  return {
    { Background = { Color = bg } },
    { Foreground = { Color = fg } },
    { Text = " " .. text .. " " },
    { Background = { Color = "none" } },
    { Text = " " },
  }
end

local function basename(s)
  if not s then return "" end
  -- s might be a path or a process name; just strip dirs
  return tostring(s):gsub(".*[/\\]", "")
end

-- Event handlers (must come BEFORE the return)
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local is_active = tab.is_active
  local title = tab.active_pane.title or "shell"

  title = title:gsub(" — .*", "")
  title = title:gsub("^.*/", "")
  title = title:gsub("^~", "🏠")
  title = title:gsub("%s+", " ")

  local bg_active = "#313244"
  local fg_active = "#cdd6f4"
  local bg_inactive = "#1e1e2e"
  local fg_inactive = "#7f849c"

  local bg = is_active and bg_active or bg_inactive
  local fg = is_active and fg_active or fg_inactive

  local cells = {}
  for _, c in ipairs(pill(title, bg, fg)) do
    table.insert(cells, c)
  end
  return cells
end)

wezterm.on("update-right-status", function(window, pane)
  local cwd = pane.current_working_dir
  local cwd_str = ""
  if cwd then
    cwd_str = (cwd.path and cwd.path) or tostring(cwd)
    cwd_str = cwd_str:gsub("^file://", "")
    cwd_str = cwd_str:gsub("%%20", " ")
    cwd_str = cwd_str:gsub("^/Users/[^/]+", "~") -- macOS
    cwd_str = cwd_str:gsub("^/home/[^/]+", "~")  -- linux
  end

  local proc = basename(pane:get_foreground_process_name())
  local time = wezterm.strftime("%H:%M")

  local parts = {}
  for _, c in ipairs(pill(cwd_str ~= "" and cwd_str or " ", "#181825", "#cdd6f4")) do table.insert(parts, c) end
  for _, c in ipairs(pill(proc ~= "" and proc or " ", "#11111b", "#a6adc8")) do table.insert(parts, c) end
  for _, c in ipairs(pill(time, "#181825", "#cdd6f4")) do table.insert(parts, c) end

  window:set_right_status(wezterm.format(parts))
end)

return {
  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = false,
  tab_bar_at_bottom = false,
  show_tab_index_in_tab_bar = false,
  window_decorations = "RESIZE", -- cleaner top bar
  use_resize_increments = false, -- allow arbitrary window sizes for Hammerspoon

  keys = {
    { key = "Enter", mods = "CMD", action = act.ToggleFullScreen },
    { key = "Enter", mods = "SHIFT", action = act.SendString("\n") },
  },

  window_padding = { left = 6, right = 6, top = 6, bottom = 6 },

  font = wezterm.font("FiraCode Nerd Font", { weight = "Medium" }),
  font_size = 12,
  line_height = 1.1,

  color_scheme = "Catppuccin Mocha",
  colors = {
    tab_bar = {
      background = "#11111b",
    },
  },

  mouse_bindings = {
    {
      event = { Up = { streak = 1, button = "Left" } },
      mods = "CMD",
      action = act.OpenLinkAtMouseCursor,
    },
  },

  enable_scroll_bar = false,
  send_composed_key_when_left_alt_is_pressed = true,
  use_ime = true,
  window_close_confirmation = "NeverPrompt",
}
