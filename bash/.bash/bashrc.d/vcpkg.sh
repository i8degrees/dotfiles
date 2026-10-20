# ~/.bash/bashrc.d/vcpkg.sh:jeff
#
# shellcheck shell=bash
#
# C++ development env
#
# SEE ALSO
# 1. xxx
#

# vcpkg env
if [ -d "${HOME}/.local/share/vcpkg" ]; then
  if [ -x "${HOME}/.local/share/vcpkg/vcpkg" ]; then
    echo "INFO: Initializing vcpkg env..."
    echo
    VCPKG_ROOT="${HOME}/.local/share/vcpkg"
    PATH=${VCPKG_ROOT}:$PATH

    source "${VCPKG_ROOT}/scripts/vcpkg_completion.bash"
  elif [ -x "${HOME}/.local/share/vcpkg/bootstrap-vcpkg.sh" ]; then
    echo "INFO: Initializing vcpkg repo..."
    echo
    "${HOME}/.local/share/vcpkg/bootstrap-vcpkg.sh"
  fi
fi

