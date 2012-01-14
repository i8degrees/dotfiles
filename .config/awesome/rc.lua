-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
require("awful.remote")

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
beautiful.init("/home/jeff/.config/awesome/themes/jeff/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = os.getenv("TERMINAL") or "urxvtc"
fm = "/usr/bin/thunar"
xkill = "/usr/bin/xkill"
editor = os.getenv("VISUAL") or "scite"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.

modkey1 = "Mod4" -- Windows Meta key
modkey2 = "Mod1" -- Alt_L || Alt_R keys
modkey3 = "Shift" -- Shift_L || Shift_R keys
modkey4 = "Control" -- Control_L || Control_R keys

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.tile,
    awful.layout.suit.fair.horizontal
}

-- Tags
-- Define a tag table which hold all screen tags.
--tags = {
--    -- Screen 0
--    settings = {
--    {
--        names = {
--            "root",
--            "www",
--            "gfx",
--            "sfx",
--            "games",
--            "msg",
--            "hax"
--        },
--        layout = {
--            layouts[1],
--            layouts[2],
--            layouts[1],
--            layouts[2],
--            layouts[1],
--            layouts[1],
--            layouts[1]
--        }
--    },
--    -- Screen 1
--    {
--        names = {
--            "root",
--            "www",
--            "gfx",
--            "sfx",
--            "msg",
--            "hax"
--        },
--        layout = {
--            layouts[1],
--            layouts[2],
--            layouts[1],
--            layouts[2],
--            layouts[1],
--            layouts[1]
--        }
--}}}

-- Tags
-- Define a tag table which hold all screen tags.
tags = {
    names = {
        "root",
        "www",
        "gfx",
        "sfx",
        "msg",
        "hax"
    },
    layout = {
        layouts[1],
        layouts[2],
        layouts[1],
        layouts[2],
        layouts[1],
        layouts[1]
    }
}

for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag(tags.names, s, tags.layout)
end

--for s = 1, screen.count() do
--    -- Each screen has its own tag table.
--    tags[s] = awful.tag(tags.settings[s].names, s, tags.settings[s].layout)
--end

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock({ align = "right" })

-- Create a systray
mysystray = widget({ type = "systray" })

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey1 }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey1 }, 3, awful.client.toggletag)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if not c:isvisible() then
                                                  awful.tag.viewonly(c:tags()[1])
                                              end
                                              client.focus = c
                                              c:raise()
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            mytaglist[s],
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        mylayoutbox[s],
        s == 1 and mytextclock or nil,
        s == 2 and mytextclock,
        s == 2 and mysystray or nil,
        --s == 1 and mytextclock or nil,
        --s == 1 and mysystray or nil,
        mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
    }
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join())

clientbuttons = awful.util.table.join(
    awful.button({ }, 1,        function (c)
                                    client.focus = c
                                    c:raise()
                                end),
    awful.button({ modkey1 }, 1, awful.mouse.client.move), -- move client window
    awful.button({ modkey1 }, 3, awful.mouse.client.resize) -- resize client window
    --awful.button({ modkey3 }, 4, function (c)
                                    --client.opacity = c
                                    --if c.opacity < 1.0 then
                                        --c.opacity = c.opacity + 0.05
                                    --else
                                        --c.opacity = 1.0
                                    --end
                                --end),
    --awful.button({ modkey3 }, 5, function (c)
                                    --client.opacity = c
                                    --if c.opacity > 0.05 then
                                        --c.opacity = c.opacity - 0.05
                                    --else
                                        --c.opacity = c.opacity + 0.05
                                    --end
                                --end)
)

-- }}}

-- TODO: OSD for our 'globalkey' & perhaps even 'clientkey' actions

-- {{{ Key bindings

globalkeys = awful.util.table.join(

    awful.key( { modkey1 }, "Left", awful.tag.viewprev), -- Cycle to the previous defined tag
    awful.key( { modkey1 }, "Right", awful.tag.viewnext), -- Cycle to the next defined tag

    awful.key({ modkey1 }, "Up", function () awful.layout.inc(layouts, -1) end), -- cycle backwards layout in available list
    awful.key({ modkey1 }, "Down", function () awful.layout.inc(layouts, 1) end), -- cycle forward layout available list

    --Cycle to Next Window
    awful.key({ modkey1 }, "Tab",
        function ()
            awful.client.focus.byidx(1)
            if client.focus then
                client.focus:raise() end
            end),

    awful.key({ modkey1,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey1           }, "Return", function () awful.util.spawn(terminal) end),

    awful.key({ modkey1, modkey3 }, "r", awesome.restart),
    awful.key({ modkey1, modkey3   }, "q", awesome.quit),

    awful.key( { modkey1 }, "space", awful.client.floating.toggle ),

    awful.key( { modkey1 }, "F1",
        function ()
            awful.util.spawn (fm)
            awful.client.focus.byidx (1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey1, }, "F4", function () awful.util.spawn(xkill) end), -- instant kill target upon click

    awful.key({ modkey1, }, "r", -- Run prompt
        function ()
            --mywibox[mouse.screen]:visible()
            mypromptbox[mouse.screen]:run()
        end),

    awful.key({ modkey1 }, "x", awesome,
              function ()
                  --mywibox[mouse.screen]:visible()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
				end)

    --awful.key({ modkey1 }, "e",
        --function ()
            --mywibox[mouse.screen].visible = not mywibox[mouse.screen].visible
        --end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey1           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey1          }, "q",      function (c) c:kill()                         end),

    awful.key({ modkey2,          }, "Tab",      awful.client.movetoscreen),

    awful.key({ modkey1, modkey4 }, "r",      function (c) c:redraw()                       end),
    awful.key ( { modkey1, },  "o", function (c) c.ontop = not c.ontop end),
    awful.key ( { modkey1, },  "s", function (c) c.sticky = not c.sticky end),

    awful.key({ modkey1,           }, "m",      function (c) c.minimized = not c.minimized    end),
    awful.key({ modkey1,           }, "w",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end),

    -- Awesome FAQ: How to move and resize floaters with the keyboard?
    -- https://awesome.naquadah.org/wiki/FAQ#How_to_move_and_resize_floaters_with_the_keyboard.3F
    awful.key({ modkey1 }, "Page_Down",  function () awful.client.moveresize(  0,  20,   0,   0) end),
    awful.key({ modkey1 }, "Page_Up",    function () awful.client.moveresize(  0, -20,   0,   0) end),
    awful.key({ modkey1 }, "Home",  function () awful.client.moveresize(-20,   0,   0,   0) end),
    awful.key({ modkey1 }, "End", function () awful.client.moveresize( 20,   0,   0,   0) end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey1, modkey4 }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        -- TODO:    As this moves a window to another screen, we ought to
        --          take advantage of this commonly desired function and
        --          remap the keycode.
        awful.key({ modkey1, modkey3 }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey1 }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey1, modkey3, modkey4 }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules =
{
    -- All clients will match this rule.
    {
        rule = { },

        properties =
        {
            buttons = clientbuttons,
            keys = clientkeys,
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            size_hints_honor = true,
            focus = true,
            --floating = false,
            maximized_vertical = false,
            maximized_horizontal = false,
            ontop = false,
            sticky = false,
            opacity = 1.0
        }
    },

    -- tags[$screen][$layout]
    -- $screen is display output number; 1..4
    -- $layout is desktop virtual tag as declared above in numerical format; 1..99
    --


    -- WINE
    {
        rule = {
            class = "Wine"
        },

        properties = {
            focus = true,
            floating = true,
			function()
				if screen.count() > 1 then
					tag = tags[1][3]
				end
			end
        }
    },
    -- Firefox
    {
        rule = {
            class = "Firefox"
        },

        properties = {
            focus = true,
            floating = false,
			function()
				if screen.count() > 1 then
					tag = tags[1][2]
				end
			end
            --tag = tags[1][2][2]
        }
    },
    -- Chrome (Google)
    {
        rule = {
            class = "Google-chrome"
        },

        properties = {
            focus = true,
            floating = false,
			function()
				if screen.count() > 1 then
					tag = tags[1][2]
				end
			end
        }
    },
    -- Firefox [Dialogs]
    {
        rule = {
            class = "Firefox",
            instance = "Dialog"
        },

        properties = {
            focus = true,
            floating = true,
			function()
				if screen.count() > 1 then
					tag = tags[1][2]
				end
			end
        }
    },
    -- Firefox [Delicious Tagging]
    {
        rule = {
            class = "Firefox",
            name = "Save a Bookmark"
        },

        properties = {
            focus = true,
            floating = true,
			function()
				if screen.count() > 1 then
					tag = tags[1][2]
				end
			end
        }
    },
    -- Firefox [Downloads]
    {
        rule = {
            class = "Firefox",
            name = "Download"
        },

        properties = {
            focus = true,
            floating = false,
            function()
				if screen.count() > 1 then
					tag = tags[1][2]
				end
			end
        }
    },

    -- ggv
    {
        rule = {
            class = "Ggv"
        },

        properties = {
            focus = false,
            floating = false,
            size_hints_honor = false,
            border_width = 0,
            ontop = true
            --tag = tags[2][2]
        }
    },
    -- epdfview
    {
        rule = {
            class = "Epdfview"
        },

        properties = {
            focus = false,
            floating = false,
            size_hints_honor = false,
            border_width = 0
            --tag = tags[2][3]
        }
    },
    -- viewnior
    {
        rule = {
            class = "Viewnior"
        },

        properties = {
            size_hints_honor = false,
            focus = true,
            floating = true,
            border_width = 0,
            sticky = false,
            ontop = true,
            --tag = tags[2][3]
        }
    },
    -- urxvt
    {
        rule = {
            class = "URxvt",
            instance = "urxvt"
        },

        properties = {
            size_hints_honor = false,
            focus = true,
            floating = false,
            border_width = 0
        }
    },
    -- Mplayer
    {
        rule = {
            class = "MPlayer"
        },

        properties = {
            size_hints_honor = false,
            focus = true,
            floating = true,
			ontop = true,
            sticky = false,
            border_width = 0
        }
    },
    -- Sonata
    {
        rule = {
            class = "Sonata"
        },

        properties = {
            focus = false,
            floating = false,
            --tag = tags[2][4]
        }
    },
    -- GMPC
    {
        rule = {
            class = "Gmpc"
        },

        properties = {
            focus = false,
            floating = false,
			function()
				if screen.count() > 1 then
					tag = tags[2][4]
				end
			end
        }
    },
    -- GIMP [image window]
    {
        rule = {
            class = "Gimp",
            role = "gimp-image-window"
        },

        properties = {
            size_hints_honor = false,
            --x = 0,
            --y = 28,
            --width = 1436,
            --height = 868,
            --focus = true,
            floating = false,
			function()
				if screen.count() > 1 then
					tag = tags[1][3]
				end
			end
        }
    },
    -- GIMP [dock window]
    {
        rule = {
            class = "Gimp",
            role = "gimp-dock"
        },

        properties = {
            size_hints_honor = false,
            --x = 1139,
            --y = 28,
            --width = 297,
            --height = 868,
            focus = false,
            floating = false,
			function()
				if screen.count() > 1 then
					tag = tags[1][3]
				end
			end
        }
    },
    -- Pidgin [conversations window]
    {
        rule = {
            class = "Pidgin",
            role = "conversation"
        },

        properties = {
            size_hints_honor = true,
            focus = true,
            floating = false,
            function()
				if screen.count() > 1 then
					tag = tags[2][5]
				end
			end
        }
        --},
        --http://comments.gmane.org/gmane.comp.window-managers.awesome/7136
        --https://awesome.naquadah.org/wiki/FAQ#How_to_start_clients_on_specific_tags_and_others_as_floating.3F
        --http://awesome.naquadah.org/wiki/Shifty
        -- TODO / FIXME
        --callback = function(c)
            --local screengeom = screen[mouse.screen].workarea
            --width = screengeom.width * 0.35
            --height = screengeom.height * 0.65
            --c:geometry({ width = 400, height = 900 })
        --end
        --geometry = { 716, 28, 720, 872 }
    },
    -- Pidgin [buddy list window]
    {
        rule = {
            class = "Pidgin",
            role = "buddy_list"
        },

        properties = {
            size_hints_honor = true,
            focus = false,
            floating = false,
            function()
				if screen.count() > 1 then
					tag = tags[2][5]
				end
			end
        }
        --},
        --http://comments.gmane.org/gmane.comp.window-managers.awesome/7136
        --https://awesome.naquadah.org/wiki/FAQ#How_to_start_clients_on_specific_tags_and_others_as_floating.3F
        --http://awesome.naquadah.org/wiki/Shifty
        -- TODO / FIXME
        --callback = function(c)
            --local screengeom = screen[mouse.screen].workarea
            --width = screengeom.width * 0.35
            --height = screengeom.height * 0.65
            --c:geometry({ width = 200, height = 900 })
        --end
        --geometry = { 716, 28, 720, 872 }
    },
	-- Xephyr [Awesome WM debugging]
    {
        rule = {
            class = "Xephyr"
        },

        properties = {
            focus = false,
            floating = true
        }
    }
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
     --awful.titlebar.add(c, { modkey1 = modkey })

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.add_signal("focus",      function(c)
                                    c.border_color = beautiful.border_focus
                                    --c.opacity = 1
                                end)
client.add_signal("unfocus",    function(c)
                                    c.border_color = beautiful.border_normal
                                    --c.opacity = 1
                                end)
-- }}}
