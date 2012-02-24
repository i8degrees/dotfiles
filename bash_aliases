# 2011-07-20:jeff
#
# 		~/.bash_aliases
#
#   Local bash (1) aliases executed for non-login interactive shells.
#

if [[ "$COLORTERM" ]]; then
	alias ls="ls -lhas --color=always"
	alias lsr="ls -lRa --color=always"
else
	alias ls="ls -lhas --color=never"
	alias lsr="ls -lRa --color=never"
fi

alias df="df -Th"
#alias du="du -csh $@|sort -nr"
alias rm="rm -iv"
alias cp="cp -iav"
alias mv="mv -iv"
alias mkdir="mkdir -pv"
alias tree="tree -Chu"
alias grep="grep --color=auto"
alias kill="kill -s SIGKILL $@"
alias pid='ps aux|pgrep "$@"'
alias watch="watch -n 1.0 $@"
alias iostat="iostat -d 1 $@"
#alias ifstat=""

alias mount_jasmine="mount /media/sshfs/jasmine/jeff"
alias umount_jasmine="fusermount -u /media/sshfs/jasmine/jeff"

alias edit="$(which geany)"
#alias edit="$VISUAL"
alias md5='md5deep -re $@' # recursive, progress
alias cls="clear"
alias diff="diff -uNr $@"
alias kpatch="patch -p1 < $@"
alias xclip="xclip -sel clip"

# TODO/FIXME
#alias 'shutdown_vbox'="VBoxManage controlvm $@ poweroff"

#if [[ "$COLORTERM" && -x "$(which colorgcc)" ]]; then
	#alias gcc="$(which colorgcc)"
	#alias g++="$(which colorgcc)"
#else
	alias gcc="$(which gcc)"
	alias g++="$(which g++)"
	alias gcc="/usr/bin/gcc"
	alias g++="/usr/bin/gcc"
#fi

if [[ "$COLORTERM" && -x "/usr/bin/colordiff" ]]; then
	alias diff="/usr/bin/colordiff"
else
	alias diff="/usr/bin/diff"
	#alias diff="/usr/bin/diff"
fi

# User specific
if [[ -n "$(id|grep jeff)" ]]; then
	alias nvidia-settings="nvidia-settings --config=$HOME/.nvidia-settings-libra &"
fi

#if [[ "$TERMINAL" == "urxvtc" && getpid 'urxvtd' > 0 ]]; then
if [[ "$TERMINAL" == "urxvtc" ]]; then
	alias urxvt='urxvtc'
fi

# Arch (Linux) specific:

#if [[ "$COLORTERM" && -x "$(which pacman-color)" ]]; then
	#alias pacman="$(which pacman-color)"
#else
	#alias pacman="$(which pacman)"
	alias pacman="/usr/bin/pacman"
#fi

#if [[ "$COLORTERM" && -x "$(which packer-color)" ]]; then
	#alias packer="$(which packer-color)"
#else
	#alias packer="$(which packer)"
	alias packer="/usr/bin/yaourt"
#fi

# TODO/FIXME: yaourt <3
alias yogurt="yaourt"
alias pkginst="pacman -S" # package install from arch repos
alias pkgupdate="pacman -Syy" # package repos update
alias pkgupgrade="pacman -Syu" # package upgrade from arch repos
#alias pkgupgrade="yaourt -Syua" # package repo upgrade, arch + AUR
alias pkgq="pacman -Q|grep $1" # package repo query (installed)
alias pkgd="yaourt -Sii $@" # package info w/ details
alias pkgs="yaourt -Ss" # package search from arch + AUR repos
alias pkgi="yaourt -Si $@" # package info
alias pkgii="pacman -Qii $@" # ???
alias pkgf="yaourt -Ql $@" # list files within package
alias pkgf?="pacman -Qo $1" # list package from which file is from
alias pkgorphan="pacman -Qdt" # list package orphans; ...
alias pkgsrc="pacman -sQm" # list locally compiled/installed packages (AUR, abs)


alias ifstat="cls && $(which ifstat) -z -i eth0,eth1 -w -S $@"
