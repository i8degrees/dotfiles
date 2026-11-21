#!/bin/sh
#
# bootstrap vendor git submodules
#

# TODO(JEFF): Add path resolving to this script; this will fail if ran from
# the vendor dir...

git submodule update --init
git submodule sync

if [ -d "vendor/human-plus-plus.git" ]; then
  cd "vendor/human-plus-plus.git"
  make
fi

