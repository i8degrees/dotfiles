# ghostty.sh:jeff
#
# shellcheck shell=bash
#
# Ghostty Shell Integration
#
# SEE ALSO
# 1. https://ghostty.org/docs/features/shell-integration
#

# Ghostty shell integration for Bash. This should be at the top of your bashrc!
if [ -n "${GHOSTTY_RESOURCES_DIR}" ]; then
  builtin source "${GHOSTTY_RESOURCES_DIR}/shell-integration/bash/ghostty.bash"
fi

