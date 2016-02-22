-- 2012-01/13:jeff
--
--		~/.config/awesome/themes/jeff/theme.lua
--
-- My awesome theme defaults

theme = {}

theme.font          = "Monospace Regular 12"

theme.bg_normal     = "#222222"
theme.bg_focus      = "#535d6c"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#444444"

theme.fg_normal     = "#aaaaaa"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.border_width  = "2"
theme.border_normal = "#000000"
theme.border_focus  = "#535d6c"
theme.border_marked = "#91231c"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Display the taglist squares
theme.taglist_squares_sel   = "/home/jeff/.config/awesome/themes/jeff/taglist/squarefw.png"
theme.taglist_squares_unsel = "/home/jeff/.config/awesome/themes/jeff/taglist/squarew.png"

theme.tasklist_floating_icon = "/usr/share/awesome/themes/default/tasklist/floatingw.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = "/home/jeff/.config/awesome/themes/jeff/submenu.png"
theme.menu_height = "15"
theme.menu_width  = "100"

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = "/home/jeff/.config/awesome/themes/jeff/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = "/home/jeff/.config/awesome/themes/jeff/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = "/home/jeff/.config/awesome/themes/jeff/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = "/home/jeff/.config/awesome/themes/jeff/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = "/home/jeff/.config/awesome/themes/jeff/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = "/home/jeff/.config/awesome/themes/jeff/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = "/home/jeff/.config/awesome/themes/jeff/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = "/home/jeff/.config/awesome/themes/jeff/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = "/home/jeff/.config/awesome/themes/jeff/titlebar/sticky_normal_active.png"

theme.titlebar_sticky_button_focus_active  = "/home/jeff/.config/awesome/themes/jeff/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = "/home/jeff/.config/awesome/themes/jeff/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = "/home/jeff/.config/awesome/themes/jeff/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = "/home/jeff/.config/awesome/themes/jeff/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = "/home/jeff/.config/awesome/themes/jeff/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = "/home/jeff/.config/awesome/themes/jeff/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = "/home/jeff/.config/awesome/themes/jeff/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = "/home/jeff/.config/awesome/themes/jeff/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = "/home/jeff/.config/awesome/themes/jeff/titlebar/maximized_focus_active.png"

-- FIXME/TODO: ~/.backgrounds is our backgrounds folder default; reconsider?
theme.wallpaper_cmd = { "feh --bg-fill /home/jeff/.config/awesome/themes/jeff/background.png" }

-- Custom timer for ensuring that our X11 cursor theme holds
-- Timer cycles every $timeout interval(s)
--
-- 			REFERENCES
-- 		1.	http://awesome.naquadah.org/wiki/FAQ#How_to_change_the_cursor_theme.3F
--
--			FIXME/TODO
--		a)	daemon/PID check
-- 		b)	timer state check
--		c)	check to see which cursor theme is employed, in order to mimic its choice here;
--			think: ~/.xinitrc, or better yet, ~/.gtkrc-2.0 || ~/.gtkrc-2.0.mine

cursor_t = timer({ timeout = 60 })
cursor_t:add_signal("timeout",	function()
									awful.util.spawn_with_shell("xsetroot -cursor_name NPlus")
								end)
cursor_t:start()

awful.util.spawn_with_shell("xsetroot -cursor_name NPlus")

-- ...to infinity and beyond !

-- You can use your own layout icons like this:
theme.layout_fairh = "/home/jeff/.config/awesome/themes/jeff/layouts/fairhw.png"
theme.layout_fairv = "/home/jeff/.config/awesome/themes/jeff/layouts/fairvw.png"
theme.layout_floating  = "/home/jeff/.config/awesome/themes/jeff/layouts/floatingw.png"
theme.layout_magnifier = "/home/jeff/.config/awesome/themes/jeff/layouts/magnifierw.png"
theme.layout_max = "/home/jeff/.config/awesome/themes/jeff/layouts/maxw.png"
theme.layout_fullscreen = "/home/jeff/.config/awesome/themes/jeff/layouts/fullscreenw.png"
theme.layout_tilebottom = "/home/jeff/.config/awesome/themes/jeff/layouts/tilebottomw.png"
theme.layout_tileleft   = "/home/jeff/.config/awesome/themes/jeff/layouts/tileleftw.png"
theme.layout_tile = "/home/jeff/.config/awesome/themes/jeff/layouts/tilew.png"
theme.layout_tiletop = "/home/jeff/.config/awesome/themes/jeff/layouts/tiletopw.png"
theme.layout_spiral  = "/home/jeff/.config/awesome/themes/jeff/layouts/spiralw.png"
theme.layout_dwindle = "/home/jeff/.config/awesome/themes/jeff/layouts/dwindlew.png"

theme.awesome_icon = "/usr/share/awesome/icons/awesome16.png"

return theme
