#!/usr/bin/osascript
--
-- Jeffrey Carpenter
-- <jeffrey.carp@gmail.com>
--
-- 1. Use as an application bundle (Application file format) with option
-- "Run-only"
-- 2. Tag the resulting application bundle with "sync", "itunes", "iphone" for
-- easy Spotlight access
-- 3. Set the global device_name variable to match the name of your iPhone device
--
-- Source: http://dougscripts.com/itunes/2012/01/sync-a-wi-fi-iphone-once-a-day-with-launchd/
--
global device_name -- Our iPhone Device Name

on run --{input, parameters}

  set device_name to "Jeff's iPhone 4s"

  tell application "iTunes"
    try
      set src to (some source whose name contains device_name)
      tell src to update
    end try
  end tell

end run
