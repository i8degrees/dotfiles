
# fs1.home_root.pxar

This is a general information and help file for the additional
filesystem metadata that is generated during the backup jobs
created with `$HOME/local/bin/backup-host.sh`. Specifically,
it is the **pre** backup hook that is tasked with producing
this information and even this very file you are reading.

## usage

- complete file scan
  * `ncdu.json.gz`
- zpool history for boot-pool
  * `boot-pool.hist`
- human-readable copy of main partition table
  * `boot-pool.parts`
- binary copy of both the main and backup partition tables
  * `boot-pool.sgdisk`

### filesystem metadata

A complete file scan is done so that critical file attributes,
such as the owner, group, file name and last modified
timestamps are recorded at the time right before the backup
starts.

```shell
# Display the results with ncdu by pointing it at the
# generated file, after extraction, of course.
zcat /data/metadata/ncdu.json.gz | ncdu -2 -f-
zcat /data/metadata/ncdu.json.gz | jq . > /tmp/json
less /tmp/json
```

### partition table

**STUB**: *WIP*

### ZFS

**STUB**: *WIP*
