# Based on umaraziz0 conky configuration
# https://github.com/umaraziz0/conky-conf

conky.settings = {
  background = false,
  update_interval = 1,
  double_buffer = yes,
  no_buffers = yes,
  own_window = yes,
  own_window_type = dock,
  own_window_hints = 'undecorated,above,sticky' -- debug
  own_window_hints = 'undecorated,above,sticky,skip_taskbar,skip_pager',
  own_window_title = 'Metrics',
  own_window_colour = '000000',
  own_window_argb_visual = true,
  own_window_argb_value = 255 -- alpha
  minimum_size = '266 114',
  -- Alignment
  alignment = 'top_right'
  gap_x = 20,
  gap_y = 30,
  border_inner_margin = 8,
  border_outer_margin = 0,

  -- Graphics settings
  draw_shades = false,
  draw_outline = true,
  draw_borders = true,
  draw_graph_borders = true,
  default_graph_size = '40 150',
  show_graph_scale = no,
  show_graph_range = no,

  -- Text settings
  use_xft = true,
  xftalpha = 0
  xftfont = 'Open Sans Light:size=9'
  -- Color scheme
  default_color = 'ffffff',
  color1 = 'ffffff',
  color2 = '444444',
  color3 = '669900',
  color4 = '333333',
  color5 = '0099CC',
  own_window_transparent = false,
}

conky.text = {
  #
  ${voffset -2}${font Open Sans Light:bold:size=10}${color1}CPU$font
  ${hr 1}
  ${machine}

  #
  ${goto 10}${voffset 5}CPU1: ${cpu cpu1}%${alignr 5}${exec sensors|grep 'Core 0'|awk '{print $3}'}
  ${goto 10}${voffset -5}${color5}${cpugraph cpu1 30,275 66241C 0099CC}
  # FIXME
  #${goto 10}${voffset 5}${color 1}${cpugovernor 0}
  #
  ${goto 10}${voffset 0}${color1}CPU2: ${cpu cpu2}%${alignr 5}${exec sensors|grep 'Core 1'|awk '{print $3}'}
  ${goto 10}${voffset -5}${color5}${cpugraph cpu2 30,275 66241C 0099CC}
  #
  ${goto 10}${voffset 0}${color1}CPU3: ${cpu cpu3}%${alignr 5}${exec sensors|grep 'Core 2'|awk '{print $3}'}
  ${goto 10}${voffset -5}${color5}${cpugraph cpu3 30,275 66241C 0099CC}
  #
  ${goto 10}${voffset 0}${color1}CPU4: ${cpu cpu4}%${alignr 5}${exec sensors|grep 'Core 3'|awk '{print $3}'}
  ${goto 10}${voffset -5}${color5}${cpugraph cpu4 30,275 66241C 0099CC}
  #
  ${goto 10}${voffset 0}${color1}CPU5: ${cpu cpu5}%${alignr 5}${exec sensors|grep 'Core 4'|awk '{print $3}'}
  ${goto 10}${voffset -5}${color5}${cpugraph cpu5 30,275 66241C 0099CC}
  #
  ${goto 10}${voffset 0}${color1}CPU6: ${cpu cpu6}%${alignr 5}${exec sensors|grep 'Core 5'|awk '{print $3}'}
  ${goto 10}${voffset -5}${color5}${cpugraph cpu6 30,275 66241C 0099CC}
  #
  ${voffset -2}${font Open Sans Light:bold:size=9}${color1}MEMORY$font
  ${hr 1}
  ${color1}RAM${alignr 5}$mem / $memmax
  ${color5}${membar 15}
  #
  ${voffset -2}${font Open Sans Light:bold:size=9}${color1}GPU$font
  ${hr 1}
  ${goto 10}${color1}GPU Usage: ${execi 5 radeontop -d- -l1 | grep -o 'gpu [0-9]\{1,3\}' | cut -c 5-10}%
  ${goto 10}${voffset -5}${color5}${execgraph "radeontop -d- -l1 | grep -o 'gpu [0-9]\{1,3\}' | cut -c 5-10" 30,275 66241C 0099CC}
  ${goto 10}${color1}VRAM Usage: ${execi 5 radeontop -d- -l1 | grep -o 'vram [0-9]\{1,3\}' | cut -c 5-10}%
  ${goto 10}${voffset -5}${color5}${execgraph "radeontop -d- -l1 | grep -o 'vram [0-9]\{1,3\}' | cut -c 5-10" 30,275 66241C 0099CC}
  #
  ${color1}Top Processes${offset 20}${alignr 10}${offset -5}CPU%${offset 10}MEM%
  ${hr 1}
  ${color}${top name 1} ${alignr 10}${offset -13}${top cpu 1}${offset 15}${top mem 1}
  ${color}${top name 2} ${alignr 10}${offset -13}${top cpu 2}${offset 15}${top mem 2}
  ${color}${top name 3} ${alignr 10}${offset -13}${top cpu 3}${offset 15}${top mem 3}
  # ${color}${top name 4} ${alignr 10}${offset -13}${top cpu 4}${offset 15}${top mem 4}
  # ${color}${top name 5} ${alignr 10}${offset -13}${top cpu 5}${offset 15}${top mem 5}

  ${goto 10}${color1}${voffset -2}Total Process Count${font}${alignr 10}$processes

  ${voffset -2}${font Open Sans Light:bold:size=9}${color1}FILE SYSTEM$font
  ${hr 1}
  ${color1}ROOT${offset 20}${color5}${fs_bar 12,150 /}
  ${voffset -18}${offset 5}${color}${alignr}$color${fs_free /} free$color$font
  ${color1}boot${offset 31}${color5}${fs_bar 12,150 /boot}
  ${voffset -18}${offset 5}${color}${alignr}$color    ${fs_free /boot} free$color$font
  ${color1}EFI${offset 31}${color5}${fs_bar 12,150 /boot/efi}
  ${voffset -18}${offset 5}${color}${alignr}$color    ${fs_free /boot/efi} free$color$font
  ${color1}HOME${offset 18}${color5}${fs_bar 12,150 /home}
  ${voffset -18}${offset 5}${color}${alignr}$color    ${fs_free /home} free$color$font
  ${color1}Projects${offset 16}${color5}${fs_bar 12,150 /mnt/fs1/Projects}
  ${voffset -18}${offset 5}${color}${alignr}$color    ${fs_free /mnt/fs1/Projects} free$color$font
  ${color1}TimeMachine${offset 29}${color5}${fs_bar 12,150 /mnt/fs1/TimeMachine}
  ${voffset -18}${offset 5}${color}${alignr}$color    ${fs_free /mnt/fs1/TimeMachine} free$color$font
  ${color1}gdrive_jeff${offset 31}${color5}${fs_bar 12,150 /net/Cloud/g_jeff}
  ${voffset -18}${offset 5}${color}${alignr}$color    ${fs_free /net/Cloud/g_jeff} free$color$font


  ${voffset -2}${font Open Sans Light:bold:size=9}${color1}NETWORK$font${voffset -5}
  ${hr 1}
  ${color1}Default Gateway${offset 20}${color5}
  PHY${alignr 10}net0
  Download${alignr 10}${downspeedf net0} kbps
  Upload${alignr 10}${upspeedf net0} kbps
  Local IP${alignr 10}${addr net0}
  MAC${alignr 10}${mac net0}
  ${hr 1}
  ${color1}SAN${offset 20}${color5}
  PHY${alignr 10}net1
  Download${alignr 10}${downspeedf net1} kbps
  Upload${alignr 10}${upspeedf net1} kbps
  Local IP${alignr 10}${addr net1}
  MAC${alignr 10}${mac net1}

  ${voffset -2}${font Open Sans Light:bold:size=9}UPTIME$font${voffset -5}
  ${hr 1}
  $uptime
}
