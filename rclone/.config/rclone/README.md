# rclone

## usage

```shell
curl "https://rclone.org/install.sh" | sudo bash
# IMPORTANT(jeff): rclone v1.57 or newer is required for fstab mounting
```

### fstab

First, ensure that you have the `rclone` mount helper binary setup.

```shell
ln -sf /usr/bin/rclone /sbin/mount.rclone
```

Then, take a look at the examples given inside `contrib/fstab` for setting up
your drive mounts.

### systemd

**See also:** `contrib/systemd/rclone.service`

### scripts

    mount.sh
    remount.sh
    umount.sh

### configuration

    rclone.conf

## reference documents

<https://rclone.org/commands/rclone_mount/>
<https://blog.galt.me/how-to-mount-gdrive-in-nextcloud/>
