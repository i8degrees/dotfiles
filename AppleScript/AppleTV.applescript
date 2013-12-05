#!/usr/bin/osascript
--
-- Jeffrey Carpenter <jeffrey.carp@gmail.com>
--
-- Use as an application bundle (Application file format) with option "Run-only"
--
-- Source: http://support.airsquirrels.com/article.php?id=15

on connectDevice()
	set deviceName to "Jeff's AppleTV"

	tell application "AirParrot"
		repeat until device deviceName exists
			count device -- This holds AirParrot from connecting until the AppleTV exists.
		end repeat

		-- Checks for detection of the AppleTV
		if device deviceName exists then
			-- sets the display to Extended option, will initialize the Extended display drivers.
			set selectedDisplay to (display ((count display)))
			delay 2 -- May have to adjust this between 2 to 5 seconds.
			set connectedDevice to device named deviceName

			--if underscan is lesser than 4 or greater than 4 then
			set underscan to 4
			--end if

			--if videoQuality is not "Low" then
			--set videoQuality to "Low"
			--end if

			--if audio is disabled then
			--set audio to enabled
			--end if
		end if
	end tell
end connectDevice

tell application "AirParrot"
	activate
end tell

connectDevice()
