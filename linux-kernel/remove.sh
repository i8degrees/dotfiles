#!/usr/bin/env bash
# ./remove.sh:jeff
#

KERNEL_INSTALL_SCRIPT="/etc/kernel/install.d/0-mount-boot-parts.install"

[[ -L "$KERNEL_INSTALL_SCRIPT" ]] && rm "$KERNEL_INSTALL_SCRIPT"

