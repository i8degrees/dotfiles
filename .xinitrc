#!/bin/sh
#
# 2010-12/09:jeffrey.carp@gmail.com
#
# 		~/.xinitrc
#
#	X11 session initializations; runs startup apps followed by
#	chosen window manager, if any.
#
# See also: xinit(1)

export DESKTOP_BACKGROUND=$HOME/.backgrounds/archlinux.png
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export DISPLAY=":0"
SYNERGY_EXEC=/usr/local/bin/synergys
SYNERGY_HOST=libra.syn.localnet
SYNERGY_PARAMS="--restart --debug ERROR --address $SYNERGY_HOST --log /var/log/synergy.log"
DEFAULT_SESSION=awesome

case $1 in
	awesome)
		WINDOW_MANAGER=awesome
	;;
	xterm)
		WINDOW_MANAGER=xterm
	;;
	reboot)
		exec sudo shutdown -r now
	;;
	shutdown)
		exec sudo shutdown -h now
	;;
	sleep)
		exec sudo pm-suspend
	;;
	*)
		if [[ -n $WINDOW_MANAGER ]]; then
			WINDOW_MANAGER=$WINDOW_MANAGER
		else
			WINDOW_MANAGER=$DEFAULT_SESSION
			#echo -e "\aERROR: A session must be chosen."
			#exit
		fi
	;;
esac

# If present, load up a fresh .Xresources resources config
if [ -f $HOME/.Xresources ]; then
    xrdb -load $HOME/.Xresources # 2&>1
fi

#if [[ $TERMINAL == "urxvtc" ]]; then
	urxvtd --fork --opendisplay # 2&>1
#fi

# FIXME: As per Awesome FAQ, we *must* execute this binary
# after the window manager has been ran, due to one of their
# libraries in use (XCB methinks?) not supporting libX11cursor
# or something along those lines...
#

# cursor theme config is loaded via .Xresources and awesome's theme.lua
#xsetroot -cursor_name NPlus

#xset dpms 600 900 1200 # 2&>1
#xset +dpms # 2&>1
xset b on # 2&>1

# xautolock config is loaded via .Xresources
#xautolock -locker slimlock -detectsleep -secure & # 2&>1

# we allow awesome's theme take care of our desktop background
#if [[ ! "$WINDOW_MANAGER" = "awesome" && -f "$DESKTOP_BACKGROUND" ]]; then
#	feh --bg-fill $DESKTOP_BACKGROUND # 2&>1
#else
#	xsetroot -solid black & # 2&>1
#fi

if [ -f "$HOME/.xbindkeys" ]; then
	xbindkeys -f "$HOME"/.xbindkeys & # 2&>1
else
	# methinks, by default, xbindkeys tries to use .xbindkeysrc
	xbindkeys & # 2&>1
fi

if [ -f "$HOME/.Xmodmap" ]; then
	xmodmap ~/.Xmodmap & # 2&>1
else
	echo -e "ERROR: Xmodmap configuration is missing"
fi

# parcellite copy/paste bug creates weird autocomplete
# issues while browsing folders / typing path directly
# into location bar -- DISABLED until new tray app
# without afflicting bug can replace. -_-
#
#parcellite & # 2&>1

if [[ -f /usr/bin/unclutter && -x /usr/bin/unclutter ]]; then
	unclutter -idle 4 & # 2&>1
fi

pulseaudio --kill
blueman-applet &
#xscreensaver & # 2&>1
#nvdock & # 2&>1
nvidia-settings --load-config-only --config=$HOME/.nvidia-settings-libra & # 2&>1
system-config-printer-applet & # 2&>1
thunar --daemon & # 2&>1
gmpc & # 2&>1
#sonata & # 2&>1
#pidgin & # 2&>1
qasmixer -t & # 2&>1
pasystray & # 2&>1
#padevchooser & # 1&>1
#xcompmgr -d $DISPLAY -n -F & # 2&>1
#xfs & # 2&>1
#xhost + # 2&>1
dropboxd &
#python2.7 $HOME/src/py-cloudapp.git/cloudapp &

if [ -x $SYNERGY_EXEC ]; then
	nice -n -5 $SYNERGY_EXEC $SYNERGY_PARAMS & # 2&>1
fi

#if [[ -n "$RECOLL_CONFDIR" ]]; then
	#recollindex -m -w 300 & # 2&>1
#fi

# Source scripts in /etc/X11/xinit/xinitrc.d/
if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/*; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

if [[ -n "$WINDOW_MANAGER" ]]; then
	exec $WINDOW_MANAGER
else
	exec $DEFAULT_SESSION
fi
