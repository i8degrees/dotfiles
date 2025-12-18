#!/data/data/com.termux/files/usr/bin/bash

[ -r "$HOME/.bash/lib" ] &&
. "$HOME/.bash/lib"

if [ -n "$SYSTEM_CA" ]; then
  DEST="$SYSTEM_CA"
else
  exit 255
fi

if [ ! -d "$SYSTEM_CA" ]; then
  exit 2
fi

if [ -n "$USER_CA" ]; then
  CWD="$USER_CA"
else
  CWD="$HOME/.certs"
fi

if [ ! -d "$USER_CA" ]; then
  exit 2
fi

link() {
  prefix="$1"
  dest_str="$2"

  # dest=$(relative_path $dest_str)
  dest=$(basename -s .crt $dest_str)
  # orig/cert
  echo ln -sf "$prefix"/ "$CWD/$dest"
}


# TODO(JEFF): Use dir list of ~/.certs/orig
# shellcheck disable=SC2034
files=(
  "canon-printers_rootCA.pem.crt"
  "isrgrootx1.pem.crt"
  "isrgrootx2.pem.crt"
  "isrgrootx3.pem.crt"
  "mkcert_rootCA.pem"
  "proxmox-backup_rootCA.pem"
  "proxmox_rootCA.pem"
  "r10.pem.crt"
  "r11.pem.crt"
  "r3.pem.crt"
  "smallstep_rootCA.pem.crt"
)

link \
  $CWD/orig/canon-printers_rootCA.pem.crt \
  "$USER_CA"/canon-printers_rootCA.pem.crt
