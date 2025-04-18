# test1.sh
#
# inclusion and exclusion string tests

set -o errexit
#set -o nounset
#set -o pipefail
#set -o xtrace

source "$HOME/local/lib/pve_util.sh"
#source "$HOME/.config/proxmox-backup/pbs1.password"

EXCLUSIONS="--exclude /dev/ --exclude /mnt/ --exclude /net/ --exclude /run/ --exclude /sys/ --exclude /tmp/ --exclude /cifs/ --exclude /misc/ --exclude /proc/ --exclude /media/ --exclude /usr/src/ --exclude /var/log/ --exclude /var/run/ --exclude /timeshift --exclude /var/cache --exclude /var/lock/ --exclude /var/mail/ --exclude /var/spool/ --exclude /home/recoll/ --exclude /home/timeshift/ --exclude /var/cache/man/ --exclude /var/tmp/pamac/ --exclude /var/cache/pamac/ --exclude /var/cache/pacman/ --exclude /var/cache/rclone/ --exclude /var/cache/fscache/ --exclude /var/cache/pkgfile/ --exclude /var/cache/private/ --exclude /var/cache/ --exclude /var/lib/systemd/coredump --exclude /var/tmp/pamac-build-jeff/ --exclude /dev --exclude /etc/mtab --exclude /home/test/.cache/ --exclude /media --exclude /mnt --exclude /proc --exclude /run --exclude /sys --exclude /timeshift --exclude /var/cache/ --exclude /var/crash --exclude /var/lib/flatpak --exclude /var/lock --exclude /var/log --exclude /var/run --exclude /var/spool --exclude /var/tmp --exclude /lost+found --exclude *.cache* --exclude *node_modules* --exclude /home/linuxbrew/ --exclude /home/test --exclude /home/jeff/Backups/borg.json --exclude /home/jeff/Backups/virgo.lan --exclude /home/jeff/Backups/scorpio --exclude /home/jeff/Backups/fs1 --exclude /home/jeff/Projects/sunshine_t1_elite --exclude /home/jeff/Projects/syn-net/ --exclude /home/jeff/.local/share/akonadi/ --exclude /home/jeff/.local/share/docker/ --exclude /home/jeff/.local/share/fsearch --exclude /home/jeff/.local/share/NuGet/ --exclude /home/jeff/.local/share/baloo/ --exclude /home/jeff/Videos/pr0n/ --exclude /home/jeff/.docker/desktop/vms --exclude /home/jeff/.docker/desktop/log --exclude /home/jeff/Software/ --exclude /home/jeff/.local/share/Trash/ --exclude /root/.cache/ --exclude /root/.local/share/Trash --exclude /Cloud --exclude *Downloads* --exclude /var/cache/private/ --exclude /var/tmp/rclone/ --exclude /home/jeff/.config/google-chrome --exclude /home/jeff/.config/android-messages-desktop --exclude /home/jeff/.config/Bitwarden --exclude .android --exclude .audacity-data --exclude .cache --exclude .cargo --exclude .cddb --exclude .config/chromium --exclude .julia --exclude .local/bin --exclude .local/share/baloo --exclude .local/share/Steam --exclude .local/share/Trash --exclude .npm --exclude .pki --exclude .steam --exclude *.socket* --exclude .Xauthority --exclude .steampid --exclude .steampath --exclude /home/jeff/.local/share/docker/ --exclude /var/lib/pacman/ --exclude /home/jeff/Android/ --exclude /home/jeff/Backups/virgo.lan/ --exclude /net/Cloud/ --exclude /mnt/fs1/ --exclude /home/jeff/Projects/darling/ --exclude /home/jeff/.cache/ --exclude /home/jeff/Cloud/ --exclude /home/jeff/Android/ --exclude /home/jeff/.nodenv/versions/ --exclude /home/jeff/tmp/ --exclude /home/jeff/Desktop/jeff.macos/"

TEST1="/var/cache/apt /var/tmp /var/lock /var/run /var/mail /home/recoll /home/test"
TEST2="/boot /boot/efi /efi /opt /opt/bin /opt/sbin /opt/go /opt/python3 /opt/share /usr/local/src /var/lib"

echo from_proxmox_exclude
from_proxmox_exclude "$EXCLUSIONS"
echo

echo to_proxmox_exclude
ret=$(to_proxmox_exclude $TEST2)
echo $ret
echo

echo from_proxmox_include
from_proxmox_include "--include-dev /home --include-dev /home/scripts"
echo

echo parse_exclusions
EXCLUDES=$(parse_exclusions $TEST1)
echo $EXCLUDES

echo "parse_exclusions(null)"
EXCLUDES=$(parse_exclusions )
echo $EXCLUDES
