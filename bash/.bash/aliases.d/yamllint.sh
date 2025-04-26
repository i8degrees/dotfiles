#!/bin/sh
#
#

yamllint_bin="$(command -v yamllint)"
[ -n "$yamllint_bin" ] && alias yamllint='yamllint --no-warnings'

