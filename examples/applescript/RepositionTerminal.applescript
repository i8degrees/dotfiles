-- Automatically positions a Terminal window to a permanent, predictable location (i.e.: spanning multiple displays away) -- in other words: a poor man's "remember window position" feature.

-- Add a call to this script after launching your Terminal instance within an automated build / run script  and $$$

-- SOURCE: http://www.maximporges.com/2010/01/25/using-applescript-to-position-ichat-windows/

--    See also:
-- /Users/jeff/Projects/AppleScripts/examples
-- http://blog.manbolo.com/2013/10/25/automating-terminal-tasks-on-osx

-- The display resolutions used to compute the offsets for the display bounds:

-- (virgo.local)
-- Display 0: 1440x900
-- Display 1: 1366x768
-- Display 2: 1360x768

-- Open a new tab.
tell application "System Events"
	set terminal to application process "Terminal"
	set frontmost of terminal to true
	tell application "System Events" to tell process "Terminal" to keystroke "n" using command down
end tell
-- tell application "Terminal" to activate


-- if (the (count of the window) = 0) or (the busy of window 1 = true) then
-- 	tell application "System Events" to tell process "Terminal" to keystroke "n" using command down

-- end if

tell application "System Events" to tell process "Terminal"
	tell application "Terminal" to activate
	set position of window 1 to {2160 - 175, 200, 200, 900}
end tell


