# ~/.bash/aliases.d/termux.sh:jeff
#
# Executed by bash(1) for Termux Android 
# support
#
# SEE ALSO
# ~/.bash_profile
#

# WARNING(JEFF): This file requires support files from the
# termux stow package from my dotfiles repo

if [[ ! "$OSTYPE" =~ 'linux-android' ]]; then
  echo "termux"
  return;
fi

if [ -d $TERMUX_SYSTEM_CA ]; then
  TERMUX_SYSTEM_CA=/data/misc/user/0/cacerts-custom
  export TERMUX_SYSTEM_CA
fi

if [ -d $TERMUX_USER_CA ]; then
  TERMUX_USER_CA=$HOME/.certs
  export TERMUX_USER_CA
fi

