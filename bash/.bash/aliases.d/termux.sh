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

# TODO(JEFF): Add check for the specific [magisk
# module][1] we depend on for this path being present
#
# [1]: https://github.com/Magisk-Modules-Alt-Repo/custom-certificate-authorities.git
if [ -d $TERMUX_SYSTEM_CA ]; then
  TERMUX_SYSTEM_CA="/data/misc/user/0/cacerts-custom"
  export TERMUX_SYSTEM_CA
fi

if [ -d $TERMUX_USER_CA ]; then
  TERMUX_USER_CA=$THOME/.certs
  export TERMUX_USER_CA
fi

# TODO(JEFF): Add function for doing this check in a loop?
# TODO(JEFF): Check existance
TERMUX_USER_NOTES=$THOME/notes.git
TERMUX_USER_INV=$THOME/fs1_inv.git
TERMUX_USER_DOTFILES=$THOME/dotfiles

if [ -d $TERMUX_USER_DOTFILES ]; then
  TERMUX_USER_DOTFILES=$THOME/dotfiles
  export TERMUX_USER_DOTFILES
fi

# TODO(JEFF): Introduce PATH file with our common
# paths for working within Android w/ Termux, i.e.:
# ~/.bash/path.d

