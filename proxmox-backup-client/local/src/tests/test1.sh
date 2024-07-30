# test1.sh
#
# inclusion and exclusion string tests

set -o errexit
#set -o nounset
#set -o pipefail
#set -o xtrace

source "$HOME/local/lib/pve_util.sh"
#source "$HOME/.config/proxmox-backup/pbs1.password"

PROXMOX_INCLUDES="--include-dev /boot --include-dev /boot/efi --include-dev /efi --include-dev /opt --include-dev /opt/bin --include-dev /opt/sbin --include-dev /opt/go --include-dev /opt/python3 --include-dev /opt/share --include-dev /usr/local/src --include-dev /var/lib"

TEST1="/var/cache/apt /var/tmp /var/lock /var/run /var/mail /home/recoll /home/test"
TEST2="/boot /boot/efi /efi /opt /opt/bin /opt/sbin /opt/go /opt/python3 /opt/share /usr/local/src /var/lib"

echo from_proxmox_include
from_proxmox_include $PROXMOX_INCLUDES
echo

echo to_proxmox_include
ret=$(to_proxmox_include $TEST1)
echo $ret
echo

# if [ -z "$ret" ]; then
  # exit 2
# fi

# if [ "$ret" != "--include-dev /var/cache/apt --include-dev /var/tmp --include-dev /var/lock --include-dev /var/run --include-dev /var/mail --include-dev /home/recoll --include-dev /home/test" ]; then
  # echo $ret
  # exit 1
# fi

echo parse_inclusions
INCLUDES=$(parse_inclusions $TEST1)
echo $INCLUDES

# assert "Parsed input list with output" "1 == "$INCLUDES"
# assert "Parsed input list with output" "0 == ""
# assert "Returns 200 response" "200 == $(curl -sLo /dev/null -I -w '%{http_code}' christianwood.net)"

echo "parse_inclusions(null)"
INCLUDES=$(parse_inclusions )
echo $INCLUDES

# assertTrue $INCLUDES ""

echo generate_build_version
generate_build_version
echo

echo generate_build_version false
generate_build_version false
echo

echo generate_build_version 0
generate_build_version 0
echo

echo generate_build_version true
generate_build_version true
echo

echo generate_build_version 1
generate_build_version 1
echo
