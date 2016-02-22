#!/usr/bin/osascript
--
-- Jeffrey Carpenter <jeffrey.carp@gmail.com>
--
-- Use as an application bundle (Application file format) with option "Run-only"
--
-- Set the global deviceName variable to match the name of your AppleTV device
--
-- Source: http://support.airsquirrels.com/article.php?id=15

global debug
global deviceName

on run
  set deviceName to "Jeff's AppleTV"
  set debug to false

  tell application "AirParrot"
    activate
  end tell

  connectDevice()
end run

on connectDevice()
  tell application "AirParrot"
    repeat until device deviceName exists
      -- This holds AirParrot from connecting until the AppleTV exists.
      count device
    end repeat

    -- Checks for detection of the AppleTV
    if device deviceName exists then

      if debug is not true then
        -- Sets the display to Extended option, will initialize the Extended
        -- display drivers
        set selectedDisplay to (display ((count display)))
        delay 2 -- May need to adjust this between 2 to 5 seconds
        set connectedDevice to device named deviceName
      end if -- debug != true

    tell application "AirParrot"
      set underscan to 5 -- May need to adjust this value for your setup
    end tell

    --if audio is disabled then
      --set audio to enabled
    --end if

    end if -- deviceName exists
  end tell -- application "AirParrot"
end connectDevice
