-- ~/.wezterm.lua:jeff
--
--
local wezterm = require 'wezterm'

local HOME = wezterm.home_dir
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.font = wezterm.font "SourceCode Pro"

config.enable_scroll_bar = false
config.min_scroll_bar_height = '1cell'
config.colors = {
  scrollbar_thumb = 'pink'
}

-- https://wezfurlong.org/wezterm/config/lua/config/background.html?h=background#source-definition
config.window_background_image = HOME .. "/Pictures/wallpapers/anita.island_12407688_530562150457048_1519659826_n.jpg"
config.window_background_image_hsb = {
  brightness = 0.05,
  hue = 1.0,
  saturation = 1.0,
}
--wezterm.log_info("BG Image: " .. config.window_background_image);

return config
