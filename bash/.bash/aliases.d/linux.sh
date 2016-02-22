#!/bin/bash
#
# 2016-02/17:jeff
#
# Platform-specific Bash aliases (Linux)

# GNU coreutils
alias top='top -o %CPU -o PID -o COMMAND -o TIME -o %MEM -o PR -o S -u jeff -n43'
alias ls="ls -lhs --color=auto"
alias lsr="ls -lRa --color=auto"
alias df="df -Th"
alias rm="rm -iv"
alias cp="cp -iav"
alias mv="mv -iv"
alias mkdir="mkdir -pv"
alias chmod='chmod -v'
alias chown='chown -v'
alias ln='ln -v'
alias xclip="xclip -sel clip"

#alias edit="$(which geany)"
# alias edit="$(which vim)"

alias edit='subl $@'
alias e='edit $@'

# User specific
if [[ -n "$(id|grep jeff)" ]]; then
  if [ -x "$(which nvidia-settings)" ]; then
    alias nvidia-settings="nvidia-settings --config=$HOME/.nvidia-settings-libra &"
  fi
fi

# ArchLinux-tailored configuration:
if [ "$LOCAL" == "virgo.arch" ]; then
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
fi # end ArchLinux-tailored configuration

# grep color term support
export GREP_OPTIONS="--color=always -I"; # -I = --binary-files-without-match

if [[ $(which xdg-open) ]]; then
  alias open='xdg-open $@'
fi
