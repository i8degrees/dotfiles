
#FOO="${FOO:-default value}"
HOME_PREFIX:=/home/jeff
INSTALL_PREFIX:=/opt

all: lint

# NOTE(jeff): This target is not currently used for anything
dist: lint

# NOTE(jeff): This target is not currently used for anything
clean:
	rm -rf build/*

dev: clean lint
deinstall: uninstall
configuration: config

lint:
	shellcheck --shell=bash local/lib/pve_util.sh
	shellcheck --shell=bash local/bin/backup-host.sh
	#shellcheck --shell=bash local/bin/backup-home.sh
	shellcheck --shell=bash local/src/tests/test1.sh
	shellcheck --shell=bash local/src/tests/test2.sh
	yamllint --no-warnings local/src/pbs/compose.yml

install:
	install -o root -m755 local/bin/backup-host.sh -t "$(INSTALL_PREFIX)/sbin/"
	install -o root -m755 local/lib/pve_util.sh -t "$(INSTALL_PREFIX)/lib/"

uninstall:
	rm -f "$(INSTALL_PREFIX)/sbin/backup-host.sh"
	rm -f "$(INSTALL_PREFIX)/lib/pve_util.sh"

purge:
	echo "TODO(JEFF): This is a stub path that executes nothing yet."
	echo
	echo rm -f "$(HOME)/.config/proxmox-backup/pbs1.password.dist"
	echo rm -f "$(HOME)/.config/proxmox-backup/fingerprint"
	echo rm -f "/var/lib/proxmox-backup/fingerprint"
	echo rm -f "/var/lib/proxmox-backup/pbs1.password.dist"

config:
	echo "TODO(JEFF): This is a stub path that executes nothing yet."
	echo
	echo install -D -o root -m755 .config/proxmox-backup/ -t "$(HOME)/.config/proxmox-backup/"
	echo install -D -o root -m600 .config/proxmox-backup/fingerprint -t "/var/lib/proxmox-backup/"
	#install -D -o root -m600 .config/proxmox-backup/pbs1.password -t "/var/lib/proxmox-backup/"
	echo install -D -o root -m600 .config/proxmox-backup/pbs1.password.dist -t "/var/lib/proxmox-backup/"
	# install -o jeff -m644 .config/proxmox-backup/pbs1.password -t $(HOME_PREFIX)
