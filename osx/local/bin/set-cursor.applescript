#!/usr/bin/osascript

-- 2016-02/21:jeff

on run
  set cursor_speed to 0.5
  set cursor_sensitivity to 375

  tell application "SteerMouse"
    set text "cursor tracking speed" to cursor_speed
    set text "cursor sensitivity" to cursor_sensitivity
  end tell

end run
