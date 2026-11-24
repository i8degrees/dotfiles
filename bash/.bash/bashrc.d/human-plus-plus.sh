# ~/.bash/bashrc.d/human-plus-plus.sh:jeff
#
# shellcheck shell=bash
#
# Human Plus Plus Theme env
#

# candidate dirs
HUMAN_PP_DIRS=(
  "$HOME/.dotfiles.git"
  "$HOME/.dotfiles"
  "$HOME/dotfiles.git"
  "$HOME/dotfiles"
)

ok_dirs=()
for dir in "${HUMAN_PP_DIRS[@]}"; do
  # TODO(JEFF): Future impl should check the file count
  # in each dir before accepting it? Use GNU Find util
  # to specialize in param search
  if [ -d "$dir" ]; then
    ok_dirs+=("$dir")
  fi
done

# The repository root where the human-plus-plus git submodule lives -- this
# is critical for our tmux theme configuration at ~/.tmux/themes.tmux to
# succeed
HPP_DIR="${ok_dirs[0]}"; export HPP_DIR

# FIXME(JEFF): Check for the number of elements before
# blindly assuming!
# Use the first directory path that is found OK to
init_dir="${ok_dirs[0]}/dist/shell-init.sh" || \
  init_dir="${ok_dirs[1]}/dist/shell-init.sh"

# shellcheck disable=SC1090
[ -r "${init_dir}" ] &&
  "${init_dir}"

