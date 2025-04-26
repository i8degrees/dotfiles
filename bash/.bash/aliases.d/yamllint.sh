#!/bin/sh
#
#

yamllint_bin="$(which yamllint)"
[ -x "$yamllint_bin" ] && alias yamllint='yamllint --no-warnings'

