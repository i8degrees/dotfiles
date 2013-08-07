#!/bin/sh
#
# 2011-09/09:jeffrey.carp@gmail.com
#
#		~/.bash_logout
#

case "$(uname -s)" in
	Darwin)
	;;
	Linux)
		# restore ALSA sfx levels
		alsactl -f "$HOME/.asound.state store 0"
		alsactl -f "$HOME/.asound.state store 1"
	;;
	*)
	;;
esac
