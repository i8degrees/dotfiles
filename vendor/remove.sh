#!/bin/sh
#
# unbootstrap vendor git submodules
#

# TODO(JEFF): Add path checking to this script

git submodule deinit -f vendor/human-plus-plus.git
git submodule sync

