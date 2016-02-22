#!/bin/bash
#
# 2016-02/15:jeff
#
# Visual testing of color terminal emulation support; up to 256 colors,
# including bold, underlined and italics text

OUTPUT_TEXT="Hello, world!"

RESET="\033[0m"     # Reset colors (including bold and underlined)
RESETI=$(tput ritm) # Reset italics
BLACK="\033[0;30m"
RED="\033[31m"
LRED="\033[1;31m"
CYAN="\033[34m"
LCYAN="\033[1;34m"
YELLOW="\033[93m"
YELLOW="\033[93m"
MAGENTA="\033[35m"
GREEN="\033[0;32m"
LGREEN="\033[1;32m"
ORANGE="\033[0;33m"
PURPLE="\033[0;35m"
GREY="\033[0;36m"
BOLD="\033[1;1m"
UNDERLINED="\033[1;4m"
WHITE="\033[1;37m"

function test_basic_ansi_colors()
{
  local PATH="/usr/bin:/bin"

  echo -ne "${RESET}"
  echo "...Begin '${FUNCNAME[0]}' test..."
  echo
  echo -ne "${BLACK}${OUTPUT_TEXT} (black)\n"
  echo -ne "${CYAN}${OUTPUT_TEXT} (cyan)\n"
  echo -ne "${LCYAN}${OUTPUT_TEXT} (white)\n"
  echo -ne "${RED}${OUTPUT_TEXT} (red)\n"
  echo -ne "${LRED}${OUTPUT_TEXT} (light red)\n"
  echo -ne "${GREEN}${OUTPUT_TEXT} (green)\n"
  echo -ne "${LGREEN}${OUTPUT_TEXT} (light green)\n"
  echo -ne "${YELLOW}${OUTPUT_TEXT} (yellow)\n"
  echo -ne "${MAGENTA}${OUTPUT_TEXT} (magenta)\n"
  echo -ne "${PURPLE}${OUTPUT_TEXT} (purple)\n"
  echo -ne "${WHITE}${OUTPUT_TEXT} (white)\n"
  echo -ne "${GREEN}Hello, ${ORANGE}there! (green, orange)\n"
  echo -ne "${GREY}Goodbye! (grey)\n"
  echo
  echo -ne "${RESET}"
  echo "...End '${FUNCNAME[0]}' test..."
  echo
}

function test_ansi_color_palette()
{
  # SOURCE: http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/x329.html
  #
  #   This file echoes a bunch of color codes to the
  #   terminal to demonstrate what's available.  Each
  #   line is the color code of one forground color,
  #   out of 17 (default + 16 escapes), followed by a
  #   test use of that color on all nine background
  #   colors (default + 8 escapes).
  #

  local PATH="/usr/bin:/bin"
  local T='gYw'   # The test text

  echo "...Begin '${FUNCNAME[0]}' test..."

  echo -e "\n                 40m     41m     42m     43m\
       44m     45m     46m     47m";

  for FGs in '    m' '   1m' '  30m' '1;30m' '  31m' '1;31m' '  32m' \
             '1;32m' '  33m' '1;33m' '  34m' '1;34m' '  35m' '1;35m' \
             '  36m' '1;36m' '  37m' '1;37m';
    do FG=${FGs// /}
    echo -en " $FGs \033[$FG  $T  "
    for BG in 40m 41m 42m 43m 44m 45m 46m 47m;
      do echo -en "$EINS \033[$FG\033[$BG  $T  \033[0m";
    done
    echo;
  done
  echo
  echo -ne "${RESET}"
  echo "...End '${FUNCNAME[0]}' test..."
  echo
}

function test_256_color_palette()
{
  local PATH="/usr/bin"

  echo -ne "${RESET}"
  echo "...Begin '${FUNCNAME[0]}' test..."
  echo
  perl -e '
  # Author: Todd Larason <jtl@molehill.org>
  # $XFree86: xc/programs/xterm/vttests/256colors2.pl,v 1.1 1999/07/11 08:49:54 dawes Exp $

  # use the resources for colors 0-15 - usually more-or-less a
  # reproduction of the standard ANSI colors, but possibly more
  # pleasing shades

  # colors 16-231 are a 6x6x6 color cube
  for ($red = 0; $red < 6; $red++) {
      for ($green = 0; $green < 6; $green++) {
    for ($blue = 0; $blue < 6; $blue++) {
        printf("\x1b]4;%d;rgb:%2.2x/%2.2x/%2.2x\x1b\\",
         16 + ($red * 36) + ($green * 6) + $blue,
         int ($red * 42.5),
         int ($green * 42.5),
         int ($blue * 42.5));
    }
      }
  }

  # colors 232-255 are a grayscale ramp, intentionally leaving out
  # black and white
  for ($gray = 0; $gray < 24; $gray++) {
      $level = ($gray * 10) + 8;
      printf("\x1b]4;%d;rgb:%2.2x/%2.2x/%2.2x\x1b\\",
       232 + $gray, $level, $level, $level);
  }


  # display the colors

  # first the system ones:
  print "System colors:\n";
  for ($color = 0; $color < 8; $color++) {
      print "\x1b[48;5;${color}m  ";
  }
  print "\x1b[0m\n";
  for ($color = 8; $color < 16; $color++) {
      print "\x1b[48;5;${color}m  ";
  }
  print "\x1b[0m\n\n";

  # now the color cube
  print "Color cube, 6x6x6:\n";
  for ($green = 0; $green < 6; $green++) {
      for ($red = 0; $red < 6; $red++) {
    for ($blue = 0; $blue < 6; $blue++) {
        $color = 16 + ($red * 36) + ($green * 6) + $blue;
        print "\x1b[48;5;${color}m  ";
    }
    print "\x1b[0m ";
      }
      print "\n";
  }


  # now the grayscale ramp
  print "Grayscale ramp:\n";
  for ($color = 232; $color < 256; $color++) {
      print "\x1b[48;5;${color}m  ";
  }
  print "\x1b[0m\n";'

  echo
  echo -ne "${RESET}"
  echo "...End '${FUNCNAME[0]}' test..."
  echo
}

function test_bold_output()
{
  echo -ne "${RESET}"
  echo "...Begin '${FUNCNAME[0]}' test..."
  echo
  echo -ne "${BOLD}${YELLOW}${OUTPUT_TEXT} (bold, yellow)\n"
  echo
  echo -ne "${RESET}"
  echo "...End '${FUNCNAME[0]}' test..."
  echo
}

function test_underlined_output()
{
  echo -ne "${RESET}"
  echo "...Begin '${FUNCNAME[0]}' test..."
  echo
  echo -ne "${UNDERLINED}${RED}${OUTPUT_TEXT} (underlined, red)\n"
  echo
  echo -ne "${RESET}"
  echo "...End '${FUNCNAME[0]}' test..."
  echo
}

function test_italics_output()
{
  local PATH="/usr/bin:/bin"
  OUTPUT_TEXT="Yeah buddy; light weight!"

  echo -ne "${RESET}"
  echo "...Begin '${FUNCNAME[0]}' test..."
  echo
  echo -ne "$(tput sitm)${OUTPUT_TEXT}${RESETI} (italics)"
  echo
  echo -ne "${GREEN}$(tput sitm)${OUTPUT_TEXT} (green, italics)${RESETI}"
  echo
  echo -ne "${BOLD}${ORANGE}$(tput sitm)${OUTPUT_TEXT} (bold, orange, italics)${RESETI}"
  echo
  echo -ne "${UNDERLINED}${CYAN}$(tput sitm)${OUTPUT_TEXT} (underlined, cyan, italics)${RESETI}"
  echo
  echo -ne "${BOLD}${UNDERLINED}${RED}$(tput sitm)${OUTPUT_TEXT} (bold, underlined, red, italics)${RESETI}"
  echo
  echo -ne "${RESET}${RESETI}"
  echo "...End '${FUNCNAME[0]}' test..."
  echo
}

test_basic_ansi_colors
test_ansi_color_palette
test_256_color_palette
test_bold_output
test_underlined_output
test_italics_output

echo -ne "${RESET}${RESETI}"
echo "End of tests"
