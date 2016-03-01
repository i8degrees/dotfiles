#!/bin/bash
#
# 2016-02/17:jeff
#
# Platform-specific Bash aliases (Darwin)

#       -F     Do not calculate statistics on shared libraries, also  known
#              as frameworks.
#
#       -R     Do  not  traverse  and report the memory object map for each
#              process.
alias top='top -stats cpu,pid,command,time,rsize,pstate -user jeff -n43 -F -R -o-CPU $@'
alias www='browser $@'
alias c='pbcopy'
alias p='pbpaste'

# Install the GNU core utilities command set (ls, cp, df, ...) as the
# default when we can do so via Homebrew package.
if [[ -x "$(which brew)" && ("$(which gls)") ]]; then
  alias du='gdu -csh'
  alias ls="gls --dereference-command-line --human-readable --size -l -a --color=auto"
  alias df="gdf -Th"
  alias rm="grm -iv"
  alias cp="gcp -iav"
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

# NOTE(jeff): Command (script) file is in ~/local/bin/subl
alias edit='subl $@'
alias e='edit $@'

alias chrome='open -a "Google Chrome" --args -allow-file-access-from-files'
alias extract='open -a "Archive Utility"'
alias lsmod='kextstat'
alias modprobe='kextload $@'
alias otool='otool -L $@'

if [ -x "$(which i586-mingw32-gcc)" ]; then
  alias win32-gcc='i586-mingw32-gcc'
fi

# Homebrew package management
if [[ -x "$(which brew)" ]]; then
  alias bdepstree='TERM=xterm-256color brew uses -installed $@'
  alias bdeps='TERM=xterm-256color brew deps $@'
  alias binstall='TERM=xterm-256color brew install -vd $@'
  alias breinstall='TERM=xterm-256color brew reinstall -vd $@'
  alias bremove='TERM=xterm-256color brew remove $@'
  alias blist='TERM=xterm-256color brew leaves $@'
  alias bdoc='TERM=xterm-256color brew doctor'
  alias bupdate='TERM=xterm-256color brew update'
  alias bupgrade='TERM=xterm-256color brew upgrade --all'
  alias bsearch='TERM=xterm-256color brew search $@'
  alias boutdated='TERM=xterm-256color brew outdated $@'
  alias bpinned='TERM=xterm-256color brew list --pinned'
  alias bmissing='TERM=xterm-256color brew missing $@'

  # See also: ~/.bash/user_functions for additional definitions
fi

# grep color term support -- GREP_OPTIONS / GREP_COLOR bash vars --
# apparently does not work under OS X (v10.7.x+)
# http://www.askdavetaylor.com/force_mac_os_x_grep_to_always_output_in_color/
if [ "$(which grep)" ]; then # /usr/local/bin/grep (homebrew package)
  alias grep='grep --color=always $@'
fi

# watch is part of coreutils brew pkg, methinks
if [[ $(which watch) ]]; then
  alias watchclang="watch 'pgrep clang'"
fi

find_app 'Firefox' firefox
find_app 'Marked 2' marked
find_app 'Simulator' ios
find_app 'FileMerge' diffgui
find_app 'SourceTree' stree
find_app 'mpv' mplayer
find_app CMake cmake-gui
find_app 0xED hexedit
