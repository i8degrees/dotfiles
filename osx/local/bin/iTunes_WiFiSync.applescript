#!/usr/bin/osascript

-- 1. Use as an application bundle (Application file format) with option
-- "Run-only"
-- 2. Tag the resulting application bundle with "sync", "itunes", "iphone" for
-- easy Spotlight access
-- 3. Set the global device_name variable to match the name of your iPhone device
--
-- Source: http://dougscripts.com/itunes/2012/01/sync-a-wi-fi-iphone-once-a-day-with-launchd/

on run(input)
  set NOM_DEBUG to false
  set device_name to "iPhone"

  if length of input > 0
    set device_name to input
  end if

  if NOM_DEBUG = true
    display dialog "device_name is " & device_name
  end if

  activate application "iTunes"

  tell application "iTunes"
    try
      set src to (some source whose name contains device_name)
      tell src to update
    end try
  end tell

end run
