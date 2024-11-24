#!/usr/bin/env bash
#
#
#

source "./lib/rc.functions"

PREFIX=""
DEST_FILES=()
cmd_exec=()

if ! check_privileges "$(id -u)"; then
  PREFIX="$(sudo tic -D 2>/dev/null)"
else
  PREFIX="$(tic -D 2>/dev/null)"
fi

DEST_FILES+=(
  #"${PREFIX}/i/iTerm.app"
  "${PREFIX}/s/screen-256color-italic"
  "${PREFIX}/t/tmux-256color"
  "${PREFIX}/t/tmux"
  "${PREFIX}/x/xterm-256color-italic"
)

if [ -n "$DEBUG" ]; then
  echo "PREFIX=${PREFIX[@]}"
fi

for path in "${DEST_FILES[@]}"; do
  if ! check_privileges "$(id -u)"; then
    cmd_exec+=("sudo")
  fi

  cmd_exec+=("rm -fv ${path};")
done

[ -n "$DEBUG" ] && echo "DEBUG: ${cmd_exec[@]}"
[ -z "$DRY_RUN" ] && eval "${cmd_exec[@]}"

echo "INFO: Removal of termcap files is completed..."
echo "INFO: Please verify this by running toe!"
echo

