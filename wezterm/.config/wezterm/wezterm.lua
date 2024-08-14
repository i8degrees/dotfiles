-- ~/.wezterm.lua:jeff
--
--
local wezterm = require 'wezterm'

local HOME = wezterm.home_dir
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- 1. https://wezfurlong.org/wezterm/config/lua/config/default_cwd.html?h=set+working+directory
-- wezterm set-working-directory <CWD> <HOST>
-- FIXME(jeff): Why does this not get applied for us?
config.default_cwd = HOME.. "/Notes.git/"
-- wezterm.run_child  
--   "USE_TMUX=1 ".. HOME.. "/local/bin/tmux_init.sh"
config.default_prog = {
  HOME.. "/local/bin/tmux_init.sh"
}
config.font = wezterm.font "SourceCode Pro"

config.enable_scroll_bar = false
config.min_scroll_bar_height = '1cell'
config.exit_behavior='Hold'
config.colors = {
  scrollbar_thumb = 'pink'
}

-- NOTE(jeff): Use wezterm.action.DisableDefaultAssignment in order to pass
-- the key action to the terminal instead of acting upon it.
--
-- 1. wezterm show-keys --lua
-- 2. https://wezfurlong.org/wezterm/config/default-keys.html
config.keys = {
  {
    key = 'q',
    mods = 'CTRL',
    action = wezterm.action.Nop
    --action = wezterm.action.QuitApplication
  },
  {
    key = 'q',
    mods = 'SUPER',
    action = wezterm.action.Nop
    --action = wezterm.action.QuitApplication
  },
  {
    key = 'q',
    mods = 'ALT',
    action = wezterm.action.Nop
    --action = wezterm.action.QuitApplication
  },
  {
    key = 'h',
    mods = 'SUPER',
    action = wezterm.action.Nop
    --action = wezterm.action.Hide
  },
  {
    key = 'w',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.Nop
    --action = wezterm.action.CloseCurrentPane { confirm = true },
  },
  {
    key = 'w',
    mods = 'CTRL',
    action = wezterm.action.Nop
    --action = wezterm.action.CloseCurrentPane { confirm = true },
  },
  {
    key = 'w',
    mods = 'SUPER',
    action = wezterm.action.Nop
    --action = wezterm.action.CloseCurrentTab { confirm = true },
  },
}

-- https://wezfurlong.org/wezterm/config/lua/config/background.html?h=background#source-definition
config.window_background_image = HOME .. "/Pictures/wallpapers/anita.island_12407688_530562150457048_1519659826_n.jpg"
config.window_background_image_hsb = {
  brightness = 0.05,
  hue = 1.0,
  saturation = 1.0,
}
--wezterm.log_info("BG Image: " .. config.window_background_image);

-- https://wezfurlong.org/wezterm/multiplexing.html
config.ssh_domains = {
  {
    name = 'ns3.home',
    remote_address = 'ns3.home',
    username = 'root',
  },
  {
    name = 'ns4.home',
    remote_address = 'ns4.home',
    username = 'root',
  },
  {
    name = 'fs1.home',
    remote_address = 'fs1.home',
    username = 'jeff',
  },
  {
    name = 'scorpio.home',
    remote_address = 'scorpio.home',
    username = 'jeff',
  },
  {
    name = 'scorpio-pve.home',
    remote_address = 'scorpio-pve.home',
    username = 'root',
  },
  {
    name = 'virgo.home',
    remote_address = 'virgo.home',
    username = 'jeff',
  },
  {
    name = 'virgo-wifi.home',
    remote_address = 'virgo-wifi.home',
    username = 'jeff',
  },
}

return config
