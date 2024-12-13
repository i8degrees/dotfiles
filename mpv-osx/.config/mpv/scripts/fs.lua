-- fs.lua:jeff
--
-- REFERENCES
--    1. man mpv (8)

function on_window_change(name, value)
  if value == true then
    mp.set_property("fullscreen", "no")
  end
end

-- function on_video_change(name, value)
--   if value == true then
--     mp.set_property("pause", "yes")
--   end
-- end

mp.observe_property("stayontop", "bool", on_window_change)
