# test1.sh
#
# inclusion and exclusion string tests

set -o errexit
#set -o nounset
#set -o pipefail
#set -o xtrace

source "$HOME/local/lib/pve_util.sh"
source "$HOME/.config/proxmox-backup/pbs1.password"

ROOT_INCLUDES="--include-dev /boot --include-dev /boot/efi --include-dev /efi --include-dev /opt --include-dev /opt/bin --include-dev /opt/sbin --include-dev /opt/go --include-dev /opt/python3 --include-dev /opt/share --include-dev /usr/local/src --include-dev /var/lib"

TEST1="/boot /boot/efi /efi /opt /opt/bin /opt/sbin /opt/go /opt/python3 /opt/share /usr/local/src /var/lib"

echo from_proxmox_include
from_proxmox_include "$ROOT_INCLUDES"
echo

echo to_proxmox_include
to_proxmox_include $TEST1
echo
