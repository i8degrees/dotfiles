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

# vcpkg env
VCPKG_ROOT="${HOME}/.local/share/vcpkg"

PRIVATE_VCPKG_ROOT="${HOME}/Projects/vcpkg-ports.git"
[ -d "${PRIVATE_VCPKG_ROOT}" ] && export PRIVATE_VCPKG_ROOT

if exists_exe vcpkg &>/dev/null; then
  source "${VCPKG_ROOT}/scripts/vcpkg_completion.bash"
fi

