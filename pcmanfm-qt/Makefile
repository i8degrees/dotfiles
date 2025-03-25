# shellcheck disable=SC2148
SHELL := /bin/bash

# IMPORTANT(JEFF): Path must **NOT** end with a path delimiter

PWD = $(shell pwd)

# shellcheck disable=SC2086
# shellcheck disable=SC2283
ROOT_PREFIX ?= /

# shellcheck disable=SC2046
# shellcheck disable=SC2283
USERID = $(shell id -u)

# shellcheck disable=SC2046
# shellcheck disable=SC2283
SHELLCHECK_BIN = $(shell which shellcheck)

all: debug install

# alias targets
deinstall: clean
uninstall: clean

clean: debug privilege_check
	@echo rm -fv /.pxarexclude

debug:
	#@echo ""
	#@echo "ROOT_PREFIX=$(ROOT_PREFIX)"
	#@echo ""
	@echo "SHELL=$(SHELL)"
	@echo "PWD=$(PWD)"
	@echo "USERID=$(USERID)"
	@echo "SHELLCHECK_BIN=$(SHELLCHECK_BIN)"

privilege_check:
	@[ "$(ROOT_PREFIX)" -eq "0" ] && echo "OK"
	@[ "$(USERID)" -eq "0" ] && echo "OK"

install: debug privilege_check
	@echo "INFO: Installing additional files at $(ROOT_PREFIX)..."
	@echo

	@echo install -vC \
		"$(PWD)/local/share/proxmox-backup/pxarexclude.root" \
	"$(ROOT_PREFIX)/.pxarexclude"

lint: clean debug
	@[ -x "$(SHELLCHECK_BIN)" ] && shellcheck ./Makefile.stow
