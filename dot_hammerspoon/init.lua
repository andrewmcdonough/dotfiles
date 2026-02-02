hs.alert.show("Hammerspoon loaded")
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
  hs.reload()
end)

-- Keyboard shortcuts


function send_window(start_column, width_in_columns, total_columns)
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.w * (start_column / total_columns)
  f.w = max.w * 2 / 9
  f.y = 0
  f.h = max.h
  win:setFrame(f)
end

-- Send window to left column (widescreen)
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "h", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = 0
  f.w = max.w * 2 / 9
  f.y = 0
  f.h = max.h
  win:setFrame(f)
end)

-- Send window to right column (widescreen)
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "l", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.w - max.w * 2 / 9
  f.w = max.w * 2 / 9
  f.y = 0
  f.h = max.h
  win:setFrame(f)
end)

-- Send window to middle (widescreen)
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "k", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.w * 2 / 9
  f.w = max.w * 5 / 9
  f.y = 0
  f.h = max.h
  win:setFrame(f)
end)

-- Send window to left of middle column (widescreen)
hs.hotkey.bind({"cmd", "alt", "ctrl"}, ",", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.w * 2 / 9
  f.w = max.w * 5 / 18
  f.y = 0
  f.h = max.h
  win:setFrame(f)
end)

-- Send window to right of middle column (widescreen)
hs.hotkey.bind({"cmd", "alt", "ctrl"}, ".", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.w * 1 / 2
  f.w = max.w * 5 / 18
  f.y = 0
  f.h = max.h
  win:setFrame(f)
end)


-- Send window to left 50%
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Left", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = 0 
  f.w = max.w * 1 / 2
  f.y = 0
  f.h = max.h
  win:setFrame(f)
end)


-- Send window to right 50%
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Right", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.w * 1 / 2
  f.w = max.w * 1 / 2
  f.y = 0
  f.h = max.h
  win:setFrame(f)
end)

-- Send window to fullscreen
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Up", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = 0
  f.w = max.w
  f.y = 0
  f.h = max.h
  win:setFrame(f)
end)

-- Minimize window
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Down", function()
  local win = hs.window.focusedWindow()

  win:minimize()
end)
