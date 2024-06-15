# logrotate

## usage

1. `cd ~/dotfiles.git; stow logrotate`
1. Add `include /home/jeff/.config/logrotate.d` to the bottom of your global
`logrotate` configuration -- `/etc/logrotate.conf` is a default.
1. Profit!

### verify

1. `sudo systemctl restart logrotate`
1. `sudo systemctl status logrotate`
1. `sudo logrotate --force`

Now you should observe a zero byte log file.

## TODO

- [ ] Logrotate seems to require our local configuration file to be owned by
`root`. We must figure out how to work around this somehow if we are to keep
this file in its current location.

- [ ] Relocate this file as a sub heading of our repositories root `README.md`

