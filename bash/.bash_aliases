#!/bin/bash
#
# 2011-07-20:jeff
#
#     ~/.bash_aliases
#
# Local bash (1) aliases executed for interactive shells.
#

alias rebash='source ~/.bash_profile'

# Clear BASH history, flush immediately && reload shell
alias chistory='history -cw && rebash'

alias ncdu='ncdu -x $@'

if [ "$(command -v md5deep)" ]; then
  alias md5='md5deep -re' # recursive, progress
else
  alias md5='md5sum'
fi

if [ "$(command -v colormake)" ]; then
  alias make='colormake'
fi

if [ "$(command -v cmake)" ]; then
  alias cmakeclean='make clean; make uninstall; rm -rf CMakeFiles CMakeCache.txt cmake_install.cmake cmake_uninstall.cmake CPackConfig.cmake CPackSourceConfig.cmake Makefile'
fi

if [ "$(command -v git)" ]; then
  alias gpush='git push -u $@'
  alias gcheckout='git checkout $@'
  alias gmerge='git merge --no-ff $@'
  alias gclone='git clone $@'
  # Compare branches to determine which branch <source> is based from
  # $1 = <source>
  # $2 = <relation>
  alias gbase='git show-branch $1 $2'
  #alias gbase='git show --summary `git merge-base branch $1`'
  alias grev='git rev-parse --short HEAD'
fi

# TODO: combine tar, zip, ... creation and listing as one do-it-all function
if [[ "$(command -v tar)" ]]; then
  if [[ "$(command -v tarcolor)" ]]; then # lesspipe bash script
    alias listtar='tar -tvf $@ | tarcolor'
  else
    alias listtar='tar -tvf $@'
  fi

  alias createtar='tar -czvf $@'
  #FIXME: alias createtar='tar -czvf $1 --exclude=*.DS_Store $2'
fi

if [[ "$(command -v zip)" ]]; then
  alias createzip='zip -r $@'
fi

if [[ "$(command -v wget)" ]]; then
  alias dl='wget $@'
fi

if [[ "$(command -v valgrind)" ]]; then
  alias memleaks=' valgrind --tool=memcheck --leak-check=full --num-callers=40 $@'
fi

# Quick access to comparing nomlib's screen-shots from visual unit tests
if [[ "$(command -v md5)" ]]; then
  alias dupe='md5 $@'
fi

case "$(uname -s)" in
  Darwin)

    #       -F     Do not calculate statistics on shared libraries, also  known
    #              as frameworks.
    #
    #       -R     Do  not  traverse  and report the memory object map for each
    #              process.
    alias top='top -stats cpu,pid,command,time,rsize,pstate -user jeff -n43 -F -R -o-CPU $@'
    alias www='browser $@'
    alias c='pbcopy'
    alias p='pbpaste'

    # coreutils package from Homebrew for GNU commands to replace Darwin BSD
    # defaults
    if [ "$(brew) -o $(brew list|grep coreutils)" ]; then
      alias du='gdu -csh'
      alias ls="gls --dereference-command-line --human-readable --size -l -a --color=auto"
      alias df="gdf -Th"
      alias rm="grm -iv"
      alias cp="gcp -iav --reflink=auto"
      alias mv="gmv -iv"
      alias mkdir="gmkdir -pv"
      alias rmdir='grmdir -v'
      alias chmod='gchmod -v'
      alias chown='gchown -v'
      alias ln='gln -v'
      alias find='gfind'
      alias dmesg='sudo dmesg'
      alias eject='diskutil eject $@'
      alias mount_ext4='ext4fuse -o allow_other $@'
      #alias cloc='cloc --by-file-by-lang --exclude-list-file=.cloc $@'
      alias route='netstat -nr'
      alias leaks='iprofiler -T 300 -allocations -leaks $@'
    fi

    #alias pgrep="psgrep"

    # ~/local/bin/subl is a symbolic link to
    # $HOME/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl
    alias edit='subl $@'
    alias e='edit $@'

    alias chrome='open -a "Google Chrome" --args -allow-file-access-from-files'
    alias marked='open -a "Marked"'

    alias iphone='open -a "/Applications/Xcode.app/Contents/Developer/Applications/Simulator.app/" --args $@'

    alias extract='open -a "Archive Utility"'
    alias lsmod='kextstat'
    alias modprobe='kextload $@'
    alias otool='otool -L $@'

    if [ -x "$(command -v i586-mingw32-gcc)" ]; then
      alias win32-gcc='i586-mingw32-gcc'
    fi

    # Homebrew package management
    if [[ -x "$(command -v brew)" ]]; then
      alias bdepstree='brew uses -installed $@'
      alias bdeps='brew deps $@'
      alias binstall='brew install -vd $@'
      alias breinstall='brew reinstall -vd $@'
      alias bremove='brew remove $@'
      alias blist='brew leaves $@'
      alias bdoc='brew doctor'
      alias bupdate='brew update'
      alias bupgrade='brew upgrade --all'
      alias bsearch='brew search $@'
      alias boutdated='brew outdated $@'
      alias bpinned='brew list --pinned'
      alias bmissing='brew missing $@'

      # See also: ~/.bashlib for additional definitions
    fi

    # grep color term support -- GREP_OPTIONS / GREP_COLOR bash vars --
    # apparently does not work under OS X (v10.7.x+)
    # http://www.askdavetaylor.com/force_mac_os_x_grep_to_always_output_in_color/
    if [ "$(command -v grep)" ]; then # /usr/local/bin/grep (homebrew package)
      alias grep='grep --color=always -I $@'
    fi

    # iOS Simulator
    alias simios='open /Applications/Xcode.app/Contents/Developer/Applications/iOS\ Simulator.app'
    alias diffgui='open /Applications/Xcode.app/Contents/Applications/FileMerge.app'

    # Open SourceTree app at specified path(s)
    if [[ -x "$HOME/Applications/SourceTree.app/Contents/MacOS/SourceTree" ]]; then
      alias stree='open -a SourceTree $@'
    fi

    if [[ "$(command -v mpv)" ]]; then
      alias mplayer='mpv $@'
    fi

    # watch is part of coreutils brew pkg, methinks
    if [[ $(command -v watch) ]]; then
      alias watchclang="watch 'pgrep clang'"
    fi

    alias cmake-gui='${HOME}/Applications/Developer/CMake.app/Contents/MacOS/CMake $@'
    alias hexedit='${HOME}/Applications/0xED.app/Contents/MacOS/0xED'
  ;;
  Linux)
    # GNU coreutils
    alias top='top -o %CPU -o PID -o COMMAND -o TIME -o %MEM -o PR -o S -u jeff -n43'
    alias ls="ls -lhs --color=auto"
    alias lsr="ls -lRa --color=auto"
    alias df="df -Th"
    alias rm="rm -iv"
    alias cp="cp -iav --reflink=auto"
    alias mv="mv -iv"
    alias mkdir="mkdir -pv"
    alias chmod='chmod -v'
    alias chown='chown -v'
    alias ln='ln -v'

    #alias edit="$(which geany)"
    # alias edit="$(which vim)"

    # ~/local/bin/subl is a symbolic link to
    # $HOME/local/opt/SublimeText2/sublime_text
    alias edit='subl $@'
    alias e='edit $@'

    # User specific
    if [[ -n "$(id|grep jeff)" ]]; then
      if [ -x "$(command -v nvidia-settings)" ]; then
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
    #export GREP_OPTIONS="--color=always -I"; # -I = --binary-files-without-match
    alias grep='grep --color=always -I $@'

    if [[ $(command -v xdg-open) ]]; then
      alias open='xdg-open $@'
    fi
  ;;
  *)
    #alias ls="ls -lhas --color=never"
    #alias lsr="ls -lRa --color=never"
  ;;
esac

alias tree="tree -Chu"
alias killall="killall -9 $@"

alias pid="ps aux|pgrep"
alias watch="watch -n 1.0"
alias iostat="iostat -d 1"
alias ifstat="clear && $(command -v ifstat) -z -i en2 -w -S $@"

alias cls="clear"
alias kpatch="patch -p1 < $@"

# TODO/FIXME
#alias 'shutdown_vbox'="VBoxManage controlvm $@ poweroff"

#if [[ "$COLORTERM" && -x "$(which colorgcc)" ]]; then
  #alias gcc="$(which colorgcc)"
  #alias g++="$(which colorgcc)"
#else
  #alias gcc="$(which gcc)"
  #alias g++="$(which g++)"
  #alias gcc="/usr/bin/gcc"
  #alias g++="/usr/bin/gcc"
#fi

if [ -x "$(command -v colordiff)" ]; then
#if [[ "$COLORTERM" && -x "/usr/bin/colordiff" ]]; then
  alias diff="$(command -v colordiff) -r $@" # recursive
  #alias diff="$(which colordiff) -uNr $@"
else
  alias diff="$(command -v diff) -r $@" # recursive
fi

# Grep options: silent mode (do not show errors), ignore binary files, case
# in-sensitive, recursive
alias g='grep $@'
alias get_ip='echo "Public IP: $(curl --silent http://checkip.mynaughty.party 2>/dev/null)"; echo "Internal IPs: "; ifconfig|grep "192.168.12.\|192.168.15."'
#alias findfile='find $1 -name $2'

# Generic Colourizer for terminal apps
GRC_BIN=$(command -v grc)
if [[ -x $GRC_BIN ]]; then

  # Default grc cfg
  alias colourify='${GRC_BIN} -es --colour=auto'
  alias configure='colourify ./configure'
  # TODO: Swap out colordiff alias with grc variant?
  # alias diff='colourify diff'
  alias make='colourify make'
  alias gcc='colourify gcc'
  alias g++='colourify g++'
  alias as='colourify as'
  alias gas='colourify gas'
  alias ld='colourify ld'
  alias netstat='colourify netstat'
  alias ping='colourify ping'
  alias traceroute='colourify /usr/sbin/traceroute'
  alias tail='colourify tail $@'
  # alias df='colourify gdf -Th $@'
  alias cvs='colourify cvs $@'
  # TODO: Swap out gls colorize with grc variant?
  # See https://github.com/justfielding/dotfiles/commit/b66ee9468e77dea912bbf21a4866d7a89bb1d749
  # alias ls='colourify ls $@'
  # alias mount='colourify mount $@'
  # alias mount='colourify mount2 $@'
fi

alias open='xdg-open $@'
alias o='open $@'
alias start='open $@'

if [[ -n "$VISUAL" ]]; then
  alias edit="$VISUAL $*"
elif [[ -n "$EDITOR" ]]; then
  alias edit="$EDITOR $*"
fi

if [ "$(type -t edit)" != 'alias' ]; then
  alias e='edit $@'
fi

if [[ -x "$(command -v gnome-www-browser)" ]]; then
  alias www='gnome-www-browser $@'
fi

TIMG_BIN=$(command -v timg)
TIV_BIN=$(command -v tiv)

if [[ -x "$TIMG_BIN" ]]; then
  alias image='timg $@'
  alias video='timg $@'
elif [[ -x "$TIV_BIN" ]]; then
  alias image='tiv $@'
  alias video='echo Please install the timg package for video support.'
fi

if [ "$(type -t image)" != 'alias' ]; then
  alias img='image $@'
fi

if [ "$(type -t video)" != 'alias' ]; then
  alias v='video $@'
fi

if [[ -x "$(command -v MP4Box)" ]]; then
  alias mp4box='MP4Box $@'
fi

if [[ -x "$(command -v MP4Client)" ]]; then
  alias mp4c='MP4Client $@'
fi

#if [[ -x "${HOME}/Applications/Invisor Lite.app/Contents/MacOS/Invisor Lite" ]]; then
#fi

#if [[ os_check == "linux" ]]; then
  #alias mount='mount --mkdir $@'
#fi

if [[ -x "$(command -v pulsar)" && -x "$(command -v apm)" ]]; then
  alias ppm='apm $@'
fi

if [ -x "$(which mdless)" ]; then
  if [ -x "$(which resize)" ]; then
    [ -z "$COLUMNS" ] && eval "$(resize)"; WIDTH=$(expr "$COLUMNS" / 2)
      alias mdless='mdless --all-images $@'
      #alias mdless="mdless --width=\"${WIDTH}\" --all-images $@"
  else
    echo
    alias mdless='mdless --all-images $@'
  fi
fi

# https://bytefreaks.net/applications/docker/how-to-list-all-docker-container-names-and-their-ips
dip() {
  docker ps -q | xargs -n 1 docker inspect --format '{{ .Name }} {{range .NetworkSettings.Networks}} {{.IPAddress}} / {{.GlobalIPv6Address}}{{end}}' | sed 's#^/##';
}

[ -x "$(command -v -v htop)" ] && alias top='sudo htop'
[ -x "$(command -v step-cli)" ] && alias step='step-cli'

if [ -x "$(which xclip)" ]; then
  DISPLAY=:0
  alias xclip='xclip -selection clipboard'
  alias pbcopy='xclip -i'
  alias pbpaste='xclip -o'
fi

[ -x "$(which pamac)" ] && alias pamac='pamac $@ --no-upgrade --no-confirm'

