# ~/.bash/bashrc.d/nomdev.sh:jeff
#
# shellcheck shell=bash
#
# C++ development env
#
# SEE ALSO
# 1. xxx
#

# allows console output from exe built with nomlib to be in color
NOM_COLOR=1; export NOM_COLOR
# openal-soft debugging
#ALSOFT_LOGLEVEL=3

# vcpkg env bits related to nomdev
if [ -d "${HOME}/.local/share/vcpkg" ]; then
  if [ -x "${HOME}/.local/share/vcpkg/vcpkg" ]; then
    PRIVATE_VCPKG_ROOT="${HOME}/Projects/vcpkg-ports.git"
    [ -d "${PRIVATE_VCPKG_ROOT}" ] && export PRIVATE_VCPKG_ROOT
  fi
fi

