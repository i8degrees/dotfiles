#!/usr/bin/env bash
#
# ./install.sh:jeff
#


KERNEL_INSTALL_SCRIPT="$(pwd)/install.d/0-mount-boot-parts.install" 
KERNEL_INSTALL_PATH="/etc/kernel/install.d/0-mount-boot-parts.install"

[[ -f "$KERNEL_INSTALL_SCRIPT" && -d "$(dirname $KERNEL_INSTALL_PATH)" ]] && ln -sf "$KERNEL_INSTALL_SCRIPT" "$KERNEL_INSTALL_PATH"

